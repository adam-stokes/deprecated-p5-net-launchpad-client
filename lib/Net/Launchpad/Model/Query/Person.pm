package Net::Launchpad::Model::Query::Person;

# ABSTRACT: Person/people query model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'people');

__PACKAGE__->meta->make_immutable;

1;
