package Net::Launchpad::Role::CVE;

# ABSTRACT: CVE roles

use Moose::Role;
use Function::Parameters;

method bugs {
    my $bugs = $self->get($self->params->{bugs_collection_link});
    return $bugs->{entries};
}

1;
