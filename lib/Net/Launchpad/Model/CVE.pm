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

use Moose::Role;
use Function::Parameters;
with 'Net::Launchpad::Model';

method by_sequence($sequence) {
    $self->cache($self->get(sprintf("%s/bugs/cve/%s", $self->api_url, $sequence)));
    return $self->cache;
}

method bugs {
    my $bugs = $self->get($self->cache->{bugs_collection_link});
    return $bugs->{entries};
}


1;

__END__

=method by_sequence

This needs to be called before any of the below methods. Takes a CVE sequence number, e.g. 2011-3188.

=method bugs

Returns a list of entries associated with cve

=cut
