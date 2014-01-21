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
    $c->staging(1);

    my $person = $c->model('Person')->by_name('~adam-stokes');

    say "Name: ". $person->name;

=cut

use Mojo::Base 'Net::Launchpad::Client';

has 'person' => '';

sub by_name {
    my ($self, $name) = @_;
    $self->person($self->get(sprintf("%s/%s", $self->api_url, $name)));
}

sub name {
    my $self = shift;
    return $self->person->{name};
}

sub karma {
    my $self = shift;
    return $self->person->{karma};
}

sub display_name {
    my $self = shift;
    return $self->person->{display_name};
}

sub date_created {
    my $self = shift;
    return $self->person->{date_created};
}

sub description {
    my $self = shift;
    return $self->person->{description};
}

sub gpg_keys {
    my $self = shift;
    my $gpg_keys = $self->get($self->person->{gpg_keys_collection_link});
    return $gpg_keys->{entries};
}

sub irc_nicks {
    my $self = shift;
    my $irc_nicks = $self->get($self->person->{irc_nicknames_collection_link});
    return $irc_nicks->{entries};
}

sub is_team {
    my $self = shift;
    return $self->person->{is_team};
}

sub is_ubuntu_coc_signer {
    my $self = shift;
    return $self->person->{is_ubuntu_coc_signer};
}

sub is_valid {
    my $self = shift;
    return $self->person->{is_valid};
}

sub ppas {
    my $self = shift;
    my $ppas = $self->get($self->person->{ppas_collection_link});
    return $ppas->{entries};
}

sub private {
    my $self = shift;
    return $self->person->{private};
}

sub source_recipes {
    my $self = shift;
    my $s_recipes = $self->get($self->person->{recipes_collection_link});
    return $s_recipes->{entries};
}

sub ssh_keys {
    my $self = shift;
    my $ssh_keys = $self->get($self->person->{sshkeys_collection_link});
    return $ssh_keys->{entries};

}

sub time_zone {
    my $self = shift;
    return $self->person->{time_zone};
}

sub web_link {
    my $self = shift;
    return $self->person->{web_link};
}

1;

__END__

=attr person

Holds person object.

=method by_name

This needs to be called before any of the below methods. Takes a login
id, e.g. ~adam-stokes

=method name

Returns person name.

=method karma

Returns person karma.

=method display_name

Returns friendly display name

=method date_created

Returns date person registered

=method description

Returns description blob

=method gpg_keys

Returns list a gpg keys registered

=method irc_nicks

Returns list of irc nicks

=method is_team

Returns whether collection is a person or team

=method is_ubuntu_coc_signer

Returns if person signed Ubuntu COC

=method is_valid

Returns if person is valid and not a deactivated account

=method ppas

Returns list of ppas associated

=method private

Returns if person or team is registered as private

=method source_recipes

Returns recipe collection of package builds

=method ssh_keys

Returns list of public ssh keys

=method time_zone

Returns persons time zone

=method web_link

Returns friendly display name, usually first and last name.

=cut

