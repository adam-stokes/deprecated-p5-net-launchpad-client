package Net::Launchpad::Model::Query::Branch;

# ABSTRACT: Branch query model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;
