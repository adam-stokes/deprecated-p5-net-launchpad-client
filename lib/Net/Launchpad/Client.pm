package Net::Launchpad::Client;

use Mojo::Base -base;
use Mojo::JSON;
use Mojo::UserAgent;
use URI::Encode;
use URI::QueryParam;
use URI;

our $VERSION = '0.99_1';

has 'staging' => 0;

has 'json' => sub {
    my $self = shift;
    return Mojo::JSON->new;
};

has 'ua' => sub {
    my $self = shift;
    my $ua   = Mojo::UserAgent->new;
    $ua->transactor->name("Net::Launchpad/$VERSION");
    return $ua;
};

sub api_url {
    my $self = shift;
    if ($self->staging) {
      return Mojo::URL->new('https://api.staging.launchpad.net/1.0/');
    }
    else {
      return Mojo::URL->new('https://api.launchpad.net/1.0/');
    }
}

sub __query_from_hash {
    my ($self, $params) = @_;
    my $uri = URI->new;
    for my $param (keys $params) {
        $uri->query_param_append($param, $params->{$param});
    }
    return $uri->query;
}

# construct path, if a resource link just provide as is.
sub __path_cons {
    my ($self, $path) = @_;
    if ($path =~ /^http.*api/) {
        return Mojo::URL->new($path);
    }
    return $self->api_url->path($path);
}

sub __oauth_authorization_header {
    my ($self, $request) = @_;
    my $enc = URI::Encode->new({encode_reserved => 1});
    return join(",",
        'OAuth realm="https://api.launchpad.net"',
        'oauth_consumer_key="' . $request->consumer_key . '"',
        'oauth_token="' . $request->token . '"',
        'oauth_signature_method="PLAINTEXT"',
        'oauth_signature="' . $enc->encode($request->signature) . '"',
        'oauth_timestamp="' . $request->timestamp . '"',
        'oauth_nonce="' . $request->nonce . '"',
        'oauth_version="' . $request->version . '"');
}

sub _request {
    my ($self, $resource, $params, $method) = @_;
    my $uri = $self->__path_cons($resource);

    # If no credentials we assume data is public and
    # bail out afterwards
    if (   !defined($self->consumer_key)
        || !defined($self->access_token)
        || !defined($self->access_token_secret))
    {
        my $res = $self->ua->get($uri->as_string);
        die $res->res->body unless $res->res->code == 200;
        return $self->json->decode($res->res->body);
    }

    # If we are here then it is assumed we've passed the
    # necessary credentials to access protected data
    my $request = Net::OAuth->request('protected resource')->new(
        consumer_key     => $self->consumer_key,
        consumer_secret  => '',
        token            => $self->access_token,
        token_secret     => $self->access_token_secret,
        request_url      => $uri->as_string,
        request_method   => $method,
        signature_method => 'PLAINTEXT',
        timestamp        => time,
        nonce            => $self->_nonce,
    );
    $request->sign;

    if ($method eq "POST") {
        my $_req = $self->ua->post(
            $request->normalized_request_url => {
                'Authorization' =>
                  $self->__oauth_authorization_header($request)
            }
        );
        $_req->content($self->__query_from_hash($params));
        my $res = $self->ua->get($_req);
        die "Failed to POST: " . $res->res->message unless ($res->res->code == 201);
    }
    elsif ($method eq "PATCH") {
        my $_req = $self->ua->patch(
            $request->normalized_request_url => {
                'User-Agent'   => 'imafreakinninjai/1.0',
                'Content-Type' => 'application/json',
                'Authorization' =>
                  $self->__oauth_authorization_header($request)
            }
        );
        $_req->content($self->json->encode($params));
        my $res = $self->ua->get($_req);

        # For current Launchpad API 1.0 the response code is 209
        # (Initially in draft spec for PATCH, but, later removed
        # during final)
        # FIXME: Check for Proper response code 200 after 2015 when
        # API is expired.
        die $res->{_content} unless $res->{_rc} == 209;
        return $self->json->decode($res->body);
    }
    else {
        my $res = $self->ua->get($request->to_url);
        die $res->res->body unless $res->res->code == 200;
        return $self->json->decode($res->res->body);
    }
}

sub get {
    my ($self, $resource) = @_;
    return $self->_request($resource, undef, 'GET');
}


sub post {
    my ($self, $resource, $params) = @_;
    return $self->_request($resource, $params, 'POST');
}

sub update {
    my ($self, $resource, $params) = @_;
    return $self->_request($resource, $params, 'PATCH');
}


1;

__END__

=head1 NAME

Net::Launchpad::Client - Launchpad.net Client routines

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $lp = Net::Launchpad::Client->new;

=head1 ATTRIBUTES

=head2 B<json>

A L<Mojo::JSON> object.

=head1 METHODS

=head2 B<get>

Performs a HTTP GET request for a particular resource.

=head2 B<post>

Performs a HTTP POST request for a resource.

=head2 B<update>

Performs a HTTP PATCH request to update a resource.

=head1 AUTHOR

Adam Stokes, C<< <adamjs at cpan.org> >>

=head1 BUGS

Report bugs to https://github.com/battlemidget/Net-Launchpad-Client/issues.

=head1 DEVELOPMENT

=head2 Repository

    http://github.com/battlemidget/Net-Launchpad-Client

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Launchpad::Client

=head1 SEE ALSO

=over 4

=item * L<https://launchpad.net/launchpadlib>, "Python implementation"

=back

=head1 COPYRIGHT

Copyright 2013-2014 Adam Stokes

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
