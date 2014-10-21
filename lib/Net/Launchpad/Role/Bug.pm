package Net::Launchpad::Role::Bug;

# ABSTRACT: Bug roles

use Moose::Role;
use Function::Parameters;

has lpc => (is => 'rw', isa => 'Net::Launchpad::Client');

method tasks {
    my $tasks = $self->lpc->get($self->params->{bug_tasks_collection_link});
    return $tasks->{entries};
}

method watches {
    my $watches = $self->lpc->get($self->params->{bug_watches_collection_link});
    return $watches->{entries};
}

method attachments {
    my $attachments = $self->lpc->get($self->params->{attachments_collection_link});
    return $attachments->{entries};
}

method activity {
    my $activity = $self->lpc->get($self->params->{activity_collection_link});
    return $activity->{entries};
}

method duplicate_of {
    return $self->lpc->get($self->params->{duplicate_of_link});
}

method messages {
    return $self->lpc->get($self->params->{messages_collection_link});
}

method owner {
    return $self->lpc->get($self->params->{owner_link});
}

1;
