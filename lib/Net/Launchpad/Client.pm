package Net::Launchpad::Client;
# ABSTRACT: Launchpad.net Client

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $lp = Net::Launchpad::Client->new(
        access_token        => '32432432432',
        access_token_secret => '32432432423432423432423232',
        consumer_key        => 'a-named-key'
    );

=cut

use Mojo::Base -base;
use Mojo::JSON;
use Mojo::UserAgent;
use Mojo::Parameters;
use Class::Load ':all';

has 'consumer_key' => '';
has 'access_token' => '';
has 'access_token_secret' => '';
has 'staging' => 0;

has 'json' => sub {
    my $self = shift;
    return Mojo::JSON->new;
};

has 'ua' => sub {
    my $self = shift;
    my $ua   = Mojo::UserAgent->new;
    $ua->transactor->name("Net::Launchpad/0.99");
    return $ua;
};

has 'nonce' => sub {
    my $self  = shift;
    my @a     = ('A' .. 'Z', 'a' .. 'z', 0 .. 9);
    my $nonce = '';
    for (0 .. 31) {
        $nonce .= $a[rand(scalar(@a))];
    }
    return $nonce;
};

has 'authorization_header' => sub {
    my $self = shift;
    return join(",",
        'OAuth realm="https://api.launchpad.net"',
        'oauth_consumer_key=' . $self->consumer_key,
        'oauth_version=1.0',
        'oauth_signature_method=PLAINTEXT',
        'oauth_signature=' . '&' . $self->access_token_secret,
        'oauth_token=' . $self->access_token,
        'oauth_token_secret=' . $self->access_token_secret,
        'oauth_timestamp=' . time,
        'oauth_nonce=' . $self->nonce);
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

sub model {
    my ($self, $class) = @_;
    my $model = "Net::Launchpad::Model::$class";
    return load_class($model)->new($self);
}

sub __path_cons {
    my ($self, $path) = @_;
    if ($path =~ /^http.*api/) {
        return Mojo::URL->new($path);
    }
    return $self->api_url->path($path);
}

sub get {
    my ($self, $resource) = @_;
    my $uri = $self->__path_cons($resource);
    my $tx =
      $self->ua->get(
        $uri->to_string => {'Authorization' => $self->authorization_header});
    die $tx->res->body unless $tx->success;
    return $self->json->decode($tx->res->body);
}

sub post {
    my ($self, $resource, $params) = @_;
    my $params_hash = Mojo::Parameters->new($params);
    my $uri         = $self->__path_cons($resource);
    my $tx =
      $self->ua->post($uri->to_string =>
          {'Authorization' => $self->authorization_header} => form =>
          $params_hash->to_string);
    die $tx->res->message unless $tx->success;
}

1;

=attr json

json object

=attr consumer_key

OAuth Consumer key

=attr access_token

OAuth access token

=attr access_token_secret

OAuth access_token_secret

=attr ua

useragent

=attr staging

Staging or Production boolean

=attr nonce

Nonce

=attr authorization_header

Authorization string as described at L<https://help.launchpad.net/API/SigningRequests> B<Using the credentials>

=method __path_cons

(Private) Returns either full resource link or combined path depending on the query.

=method api_url

Launchpad API host

=method get

Performs a HTTP GET request for a particular resource.

=method post

Performs a HTTP POST request for a resource.

=head1 SEE ALSO

L<https://api.launchpad.net>

=cut
