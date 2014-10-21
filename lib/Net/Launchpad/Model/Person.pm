package Net::Launchpad::Model::Person;
# ABSTRACT: Person model

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Model::Person
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $model = Net::Launchpad::Model::Person->new(client => $c);
    my $person = $model->by_name('~adam-stokes');

    print "Name: ". $person->{name};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

has params => (is => 'rw', isa => 'HashRef');


__PACKAGE__->meta->make_immutable;
1;

