#!/usr/bin/env perl
#
# for quick tests only, should not be depended upon for
# proper examples of current api.

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use Net::Launchpad::Model::Bug;
use List::AllUtils qw(first);
use Hash::AsObject;
use Data::Dumper::Concise;

my $public_bug = $ENV{LP_BUG} || '1268207';

my $model = Net::Launchpad::Model::Bug->new(
    consumer_key        => $ENV{LP_CONSUMER_KEY},
    access_token        => $ENV{LP_ACCESS_TOKEN},
    access_token_secret => $ENV{LP_ACCESS_TOKEN_SECRET}
);

$model->by_id($public_bug);
my $tasks = $model->tasks;
print Dumper($tasks);

my $person = Net::Launchpad::Model::Person->new(
    consumer_key        => $ENV{LP_CONSUMER_KEY},
    access_token        => $ENV{LP_ACCESS_TOKEN},
    access_token_secret => $ENV{LP_ACCESS_TOKEN_SECRET}
);

#p $bug_item;
# p $bug->tasks;
# p $bug->date_created;
# p $bug->watches;
# my $bugtask =
#   first { $_->{bug_target_name} =~ /ubuntu-advantage|(Ubuntu)/ } @{$bug->tasks};
# # p $bugtask;
# my $person = $c->model('Person')->by_name('~adam-stokes');
# p $person;
# p $person->ppas;
