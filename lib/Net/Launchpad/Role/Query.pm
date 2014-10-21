package Net::Launchpad::Role::Query;

# ABSTRACT: Common pure query roles

use Moose::Role;
use Function::Parameters;
use Mojo::Parameters;

=method _build_resource_path

Builds a resource path with params encoded

=cut

method _build_resource_path ($search_name, $params) {
    $params = Mojo::Parameters->new($params);
    return sprintf("%s?%s", $search_name, $params->to_string);
}

=method resource

Returns resource of C<name>

=cut

method resource ($path, $params) {
    my $uri = $self->_build_resource_path($path, $params);
    return $self->lpc->get($uri);
}

1;
