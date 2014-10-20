package Net::Launchpad::Model::Bug;
# ABSTRACT: Bug Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $bug = $c->bug->by_id(3);

    print "Title: ". $bug->{title};
    print "Desc:  ". $bug->{description};
    print "Heat:  ". $bug->{heat};

=cut

use Moose::Role;
use Function::Parameters;
with 'Net::Launchpad::Model';

method by_id ($id) {
    $self->cache(
        $self->get(sprintf("%s/bugs/%s", $self->api_url, $id)));
    return $self->cache;
}

method tasks {
    my $tasks = $self->get($self->cache->{bug_tasks_collection_link});
    return $tasks->{entries};
}

method watches {
    my $watches = $self->get($self->cache->bug_watches_collection_link);
    return $watches->entries;
}

method attachments {
    my $attachments = $self->get($self->cache->attachments_collection_link);
    return $attachments->entries;
}

method activity {
    my $activity = $self->get($self->cache->activity_collection_link);
    return $activity->entries;
}

method duplicate_of {
    return $self->get($self->cache->duplicate_of_link);
}

method messages {
    return $self->get($self->cache->messages_collection_link);
}

method owner {
    return $self->get($self->cache->owner_link);
}

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
