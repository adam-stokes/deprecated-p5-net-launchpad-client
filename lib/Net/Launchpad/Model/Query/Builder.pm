package Net::Launchpad::Model::Query::Builder;

# ABSTRACT: Builder query model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'builders');

__PACKAGE__->meta->make_immutable;

1;
