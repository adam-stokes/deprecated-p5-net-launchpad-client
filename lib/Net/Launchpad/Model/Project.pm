package Net::Launchpad::Model::Project;
# ABSTRACT: Project Model interface

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Model::Project;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $model = Net::Launchpad::Model::Project->new(client => c);
    my $project = $model->by_name('sosreport');

    print "Name: ". $project->{name};

=cut
use Moose;
use Function::Parameters;
use namespace::autoclean;

has params => (is => 'rw', isa => 'HashRef');


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

