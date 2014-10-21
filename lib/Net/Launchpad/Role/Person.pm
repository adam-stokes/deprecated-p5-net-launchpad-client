package Net::Launchpad::Role::Person;

use Moose::Role;
use Function::Parameters;

# ABSTRACT: Person roles

=method gpg_keys

Returns list a gpg keys registered

=cut
method gpg_keys {
    my $gpg_keys = $self->get($self->params->{gpg_keys_collection_link});
    return $gpg_keys->{entries};
}

=method irc_nicks

Returns list of irc nicks

=cut
method irc_nicks {
    my $irc_nicks = $self->get($self->params->{irc_nicknames_collection_link});
    return $irc_nicks->{entries};
}

=method ppas

Returns list of ppas associated

=cut
method ppas {
    my $ppas = $self->get($self->params->{ppas_collection_link});
    return $ppas->{entries};
}

=method source_recipes

Returns recipe collection of package builds

=cut
method source_recipes {
    my $s_recipes = $self->get($self->params->{recipes_collection_link});
    return $s_recipes->{entries};
}

=method ssh_keys

Returns list of public ssh keys

=cut
method ssh_keys {
    my $ssh_keys = $self->get($self->params->{sshkeys_collection_link});
    return $ssh_keys->{entries};
}

1;
