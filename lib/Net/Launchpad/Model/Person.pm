package Net::Launchpad::Model::Person;
# ABSTRACT: Person model

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $person = $c->by_name('~adam-stokes');

    print "Name: ". $person->{name};

=cut

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Model';

=method by_name

This needs to be called before any of the below methods. Takes a login
id, e.g. ~adam-stokes

=cut

method by_name ($name) {
    $self->cache($self->get(sprintf("%s/%s", $self->api_url, $name)));
    return $self->cache;
}

=method gpg_keys

Returns list a gpg keys registered

=cut
method gpg_keys {
    my $gpg_keys = $self->get($self->cache->{gpg_keys_collection_link});
    return $gpg_keys->{entries};
}

=method irc_nicks

Returns list of irc nicks

=cut
method irc_nicks {
    my $irc_nicks = $self->get($self->cache->{irc_nicknames_collection_link});
    return $irc_nicks->{entries};
}

=method ppas

Returns list of ppas associated

=cut
method ppas {
    my $ppas = $self->get($self->cache->{ppas_collection_link});
    return $ppas->{entries};
}

=method source_recipes

Returns recipe collection of package builds

=cut
method source_recipes {
    my $s_recipes = $self->get($self->cache->{recipes_collection_link});
    return $s_recipes->{entries};
}

=method ssh_keys

Returns list of public ssh keys

=cut
method ssh_keys {
    my $ssh_keys = $self->get($self->cache->{sshkeys_collection_link});
    return $ssh_keys->{entries};
}

1;

