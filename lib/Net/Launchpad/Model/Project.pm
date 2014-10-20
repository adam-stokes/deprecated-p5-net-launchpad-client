package Net::Launchpad::Model::Project;
# ABSTRACT: Project Model interface

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $project = $c->by_name('sosreport');

    print "Name: ". $project->{name};

=cut
use Moose;
use Function::Parameters;

method by_name($name) {
    $self->cache($self->get(sprintf("%s/%s", $self->api_url, $name)));
}

method owner {
    my $owner = $self->get($self->cache->{owner_link});
    return $owner;
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=attr project

Holds project object.

=method by_name

Query a project by name

=method owner

Return owner of project

=cut

