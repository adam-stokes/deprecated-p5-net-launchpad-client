package Net::Launchpad::Model::Bug;
# ABSTRACT: Bug Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Model::Bug;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $model = Net::Launchpad::Model::Bug->new(client => $c);
    my $bug = $model->by_id(3)

    print "Title: ". $bug->{title};
    print "Desc:  ". $bug->{description};
    print "Heat:  ". $bug->{heat};

=cut

use Moose;
use namespace::autoclean;
use Function::Parameters;

has params => (is => 'rw', isa => 'HashRef');

__PACKAGE__->meta->make_immutable;
1;

__END__

=method tasks

Returns a list of entries in the tasks object.

=method messages

Returns bug messages associated with Bug.

=method activity

Returns a bug activity collection

=method attachments

Returns list of bug attachments

=method duplicate_of

Returns a bug resource that the specific bug is a duplicate of

=method watches

Returns bug watch collection

=cut
