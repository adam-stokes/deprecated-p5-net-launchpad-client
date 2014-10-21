package Net::Launchpad::Query;

# ABSTRACT: Query class

use Moose;
use Moose::Util qw(apply_all_roles is_role does_role search_class_by_role);
use Function::Parameters;
use Mojo::Parameters;
use Module::Runtime qw(is_module_name use_package_optimistically);
use namespace::autoclean;

has lpc => (is => 'ro', isa => 'Net::Launchpad::Client');

method _load_model (Str $name, HashRef $params) {
    my $model_class = "Net::Launchpad::Model::$name::Query";
    my $model_role  = "Net::Launchpad::Role::$name::Query";

    die "Invalid model requested." unless is_module_name($model_class);
    die "Unknown Role module" unless is_module_name($model_role);

    my $model =
      use_package_optimistically($model_class)->new(lpc => $self->lpc);

    my $role =
      use_package_optimistically($model_role);

    die "$_ is not a role" unless is_role($role);
    $role->meta->apply($model);
}

# method bugtrackers {
#     return $self->_load_model('BugTracker');
# }

# method builders {
#     return $self->_load_model('Builder');
# }

# method countries {
#     return $self->_load_model('Country');
# }

=method branches

Search utilities for branches

=cut
method branches {
    return $self->_load_model('Branch');
}

# method people {
#     return $self->_load_model('Person');
# }

# method distributions {
#     return $self->_load_model('Distribution');
# }

# method languages {
#     return $self->_load_model('Language');
# }

# method cves {
#     return $self->_load_model('CVE');
# }

# method projects {
#     return $self->_load_model('Project');
# }


__PACKAGE__->meta->make_immutable;
1;
