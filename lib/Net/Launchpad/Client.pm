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

use Moose;
use Function::Parameters;
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::JSON qw(decode_json);
use Mojo::Parameters;
use namespace::autoclean;

=attr consumer_key

OAuth Consumer key

=attr access_token

OAuth access token

=attr access_token_secret

OAuth access_token_secret

=attr staging

Staging or Production boolean

=cut
has consumer_key        => (is => 'ro', isa => 'Str');
has access_token        => (is => 'ro', isa => 'Str');
has access_token_secret => (is => 'ro', isa => 'Str');
has staging             => (is => 'ro', isa => 'Int', default => 0);

has 'ua' => (
    is      => 'ro',
    isa     => 'Mojo::UserAgent',
    default => method {
        my $ua = Mojo::UserAgent->new;
        $ua->transactor->name("Net::Launchpad");
        return $ua;
    }
);

has 'nonce' => (
    is      => 'ro',
    isa     => 'Str',
    default => method {
        my @a = ('A' .. 'Z', 'a' .. 'z', 0 .. 9);
        my $nonce = '';
        for (0 .. 31) {
            $nonce .= $a[rand(scalar(@a))];
        }
        return $nonce;
    }
);

has 'authorization_header' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_auth_header',
    documentation =>
      "Composed authorization string for accessing priveledged data"
);

method _build_auth_header {
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
}

method api_url {
    return Mojo::URL->new('https://api.launchpad.net/1.0/')
      unless $self->staging;
    return Mojo::URL->new('https://api.staging.launchpad.net/1.0/');
}

method __path_cons($path) {
    if ($path =~ /^http.*api/) {
        return Mojo::URL->new($path);
    }
    return $self->api_url->path($path);
}

method post (Str $resource, HashRef $params) {
    my $params_hash = Mojo::Parameters->new($params);
    my $uri         = $self->__path_cons($resource);
    my $tx =
      $self->ua->post($uri->to_string =>
          {'Authorization' => $self->authorization_header} => form =>
          $params_hash->to_string);
    die $tx->res->message unless $tx->success;
}

method get (Str $resource) {
    my $uri = $self->__path_cons($resource);
    my $tx =
      $self->ua->get(
        $uri->to_string => {'Authorization' => $self->authorization_header});
    die $tx->res->body unless $tx->success;
    return decode_json($tx->res->body);
}

__PACKAGE__->meta->make_immutable;
1;
