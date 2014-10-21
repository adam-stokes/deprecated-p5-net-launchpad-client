package Net::Launchpad::Role::Project;

# ABSTRACT: Project roles

use Moose::Role;
use Function::Parameters;

method owner {
    my $owner = $self->get($self->params->{owner_link});
    return $owner;
}

1;
