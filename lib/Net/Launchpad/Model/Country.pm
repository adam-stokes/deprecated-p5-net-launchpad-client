package Net::Launchpad::Model::Country;
# ABSTRACT: Country model

=head1 DESCRIPTION

Container for countries

=cut

use Moose;
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;

