package Net::Launchpad::Model::Project;
# ABSTRACT: Project Model interface

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );
    $c->staging(1);

    my $project = $c->model('Project')->by_name('sosreport');

    print "Name: ". $project->name;

=cut

use Mojo::Base 'Net::Launchpad::Client';

has 'project' => '';

sub by_name {
    my ($self, $name) = @_;
    $self->project($self->get(sprintf("%s/%s", $self->api_url, $name)));
}

sub bug_supervisor_link {
    my $self = shift;
    return $self->project->{bug_supervisor_link};
}

sub bug_reporting_guidelines {
    my $self = shift;
    return $self->project->{bug_reporting_guidelines};
}

sub bug_tracker_link {
    my $self = shift;
    return $self->project->{bug_tracker_link};
}

sub date_created {
    my $self = shift;
    return $self->project->{date_created};
}

sub description {
    my $self = shift;
    return $self->project->{description};
}

sub name {
    my $self = shift;
    return $self->project->{name};
}

sub official_bug_tags {
    my $self = shift;
    return $self->project->{official_bug_tags};
}

sub owner {
    my $self = shift;
    my $owner = $self->get($self->project->{owner_link});
    return $owner;
}

sub summary {
    my $self = shift;
    return $self->project->{summary};
}

sub title {
    my $self = shift;
    return $self->project->{title};
}

sub web_link {
    my $self = shift;
    return $self->project->{web_link};
}

1;

__END__

=attr project

Holds project object.

=method by_name

Query a project by name

=method bug_supervisor_link

Link to bug supervisor

=cut

