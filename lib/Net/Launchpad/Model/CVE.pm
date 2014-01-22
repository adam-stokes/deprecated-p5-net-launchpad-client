package Net::Launchpad::Model::CVE;
# ABSTRACT: CVE Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );
    $c->staging(1);

    my $cve = $c->model('CVE')->by_sequence('XXXX-XXXX');

    print "Title: ". $cve->title;
    print "Desc:  ". $cve->description;

=cut

use Mojo::Base 'Net::Launchpad::Client';

has 'cve' => '';

sub by_sequence {
    my ($self, $sequence) = @_;
    $self->cve($self->get(sprintf("%s/bugs/cve/%s", $self->api_url, $sequence)));
}

sub bugs {
    my $self = shift;
    my $bugs = $self->get($self->cve->{bugs_collection_link});
    return $bugs->{entries};
}

sub display_name {
    my $self  = shift;
    return $self->cve->{display_name};
}

sub description {
    my $self = shift;
    return $self->cve->{description};
}

sub title {
    my $self = shift;
    return $self->cve->{title};
}

sub web_link {
    my $self = shift;
    return $self->cve->{web_link};
}

sub date_created {
    my $self = shift;
    return $self->cve->{date_created};
}

sub date_modified {
    my $self = shift;
    return $self->cve->{date_modified};
}

sub status {
    my $self = shift;
    return $self->cve->{status};
}

sub url {
    my $self = shift;
    return $self->cve->{url};
}

sub sequence {
    my $self = shift;
    return $self->cve->{sequence};
}


1;

__END__

=attr cve

CVE object.

=method by_sequence

This needs to be called before any of the below methods. Takes a CVE sequence number, e.g. 2011-3188.

=method sequence

Returns cve number.

=method title

Returns title of cve.

=method bugs

Returns a list of entries associated with cve

=method web_link

Returns browseable URL link to resource.

=method description

Returns cve description

=method status

Returns whether the cve is of candidate, entry, deprecated

=method date_created

Returns date cve was created

=method date_modified

Return date of last modification

=method display_name

Returns brief description of the ref and state

=method url

Returns URL to site that contains CVE data for this CVE reference.

=cut
