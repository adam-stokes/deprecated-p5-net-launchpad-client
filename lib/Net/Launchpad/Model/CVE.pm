package Net::Launchpad::Model::CVE;
# ABSTRACT: CVE Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $cve = $c->by_sequence('XXXX-XXXX');

    print "Title: ". $cve->{title};
    print "Desc:  ". $cve->{description};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

has params => (is => 'rw', isa => 'HashRef');

__PACKAGE__->meta->make_immutable;
1;

__END__

=method by_sequence

This needs to be called before any of the below methods. Takes a CVE sequence number, e.g. 2011-3188.

=method bugs

Returns a list of entries associated with cve

=cut
