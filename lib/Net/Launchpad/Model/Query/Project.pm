package Net::Launchpad::Model::Query::Project;

# ABSTRACT: Project query model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'projects');

__PACKAGE__->meta->make_immutable;

1;
