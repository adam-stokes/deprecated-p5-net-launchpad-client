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

    my $bug = $c->bug(3)

    print "Title: ". $bug->{title};
    print "Desc:  ". $bug->{description};
    print "Heat:  ". $bug->{heat};

=cut

use Moose;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;

__END__

