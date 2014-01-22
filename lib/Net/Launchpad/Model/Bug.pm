package Net::Launchpad::Model::Bug;
# ABSTRACT: Bug Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );
    $c->staging(1);

    my $bug = $c->model('Bug')->by_id(3);

    print "Title: ". $bug->title;
    print "Desc:  ". $bug->description;
    print "Heat:  ". $bug->heat;

=head1 DESCRIPTION

=cut

use Mojo::Base 'Net::Launchpad::Client';

has 'bug' => '';

sub by_id {
    my ($self, $id) = @_;
    $self->bug($self->get(sprintf("%s/bugs/%s", $self->api_url, $id)));
}

sub id {
    my $self = shift;
    return $self->bug->{id};
}

sub tasks {
    my $self  = shift;
    my $tasks = $self->get($self->bug->{bug_tasks_collection_link});
    return $tasks->{entries};
}

sub watches {
    my $self    = shift;
    my $watches = $self->get($self->bug->{bug_watches_collection_link});
    return $watches->{entries};
}

sub attachments {
    my $self        = shift;
    my $attachments = $self->get($self->bug->{attachments_collection_link});
    return $attachments->{entries};
}

sub activity {
    my $self     = shift;
    my $activity = $self->get($self->bug->{activity_collection_link});
    return $activity->{entries};
}

sub duplicate_of {
    my $self = shift;
    return $self->get($self->bug->{duplicate_of_link});
}

sub duplicate_count {
    my $self = shift;
    return $self->bug->{number_of_duplicates};
}

sub users_affected_count {
    my $self = shift;
    return $self->bug->{users_affected_count};
}

sub description {
    my $self = shift;
    return $self->bug->{description};
}

sub title {
    my $self = shift;
    return $self->bug->{title};
}

sub heat {
    my $self = shift;
    return $self->bug->{heat};
}

sub information_type {
    my $self = shift;
    return $self->bug->{information_type};
}

sub web_link {
    my $self = shift;
    return $self->bug->{web_link};
}

sub message_count {
    my $self = shift;
    return $self->bug->{message_count};
}

sub messages {
    my $self = shift;
    return $self->get($self->bug->{messages_collection_link});
}

sub tags {
    my $self = shift;
    return $self->bug->{tags};
}

sub owner {
    my $self = shift;
    return $self->get($self->bug->{owner_link});
}

sub date_created {
    my $self = shift;
    return $self->bug->{date_created};
}

sub date_last_message {
    my $self = shift;
    return $self->bug->{date_last_message};
}

sub date_last_updated {
    my $self = shift;
    return $self->bug->{date_last_updated};
}

sub can_expire {
    my $self = shift;
    return $self->bug->{can_expire};
}

1;

__END__

=attr bug

Bug object.

=method by_id

This needs to be called before any of the below methods. Takes a Bug ID number.

=method id

Returns bug number.

=method title

Returns title of bug.

=method tasks

Returns a list of entries in the tasks object.

=method owner

Returns creator of bug

=method web_link

Returns browseable URL link to resource.

=method messages

Returns bug messages associated with Bug.

=method message_count

Returns message count

=method heat

Returns heat/importance of bug

=method description

Returns bug description

=method information_type

Returns whether this bug is a public/private issue.

=method tags

Returns a list of Tags associated with bug.

=method activity

Returns a bug activity collection

=method attachments

Returns list of bug attachments

=method can_expire

Returns whether the incomplete bug can be expired

=method date_created

Returns date bug was created

=method date_last_message

Return date of last posted bug message

=method date_last_updated

Returns date of last update, can be bug message or status changes.

=method duplicate_count

Returns number of bug duplicates

=method duplicate_of

Returns a bug resource that the specific bug is a duplicate of

=method users_affected_count

Returns count of users affected by bug

=method watches

Returns bug watch collection

=cut
