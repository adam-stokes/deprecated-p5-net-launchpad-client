#!/usr/bin/env perl
#
# for quick tests only, should not be depended upon for
# proper examples of current api.

use Mojo::Base -strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use Net::Launchpad::Client;
use List::AllUtils qw(first);

use DDP;

my $public_bug = $ENV{LP_BUG} || '1268207';

my $c = Net::Launchpad::Client->new;
if (   defined($ENV{LP_CONSUMER_KEY})
    && defined($ENV{LP_ACCESS_TOKEN})
    && defined($ENV{LP_ACCESS_TOKEN_SECRET}))
{
    $c->consumer_key($ENV{LP_CONSUMER_KEY});
    $c->access_token($ENV{LP_ACCESS_TOKEN});
    $c->access_token_secret($ENV{LP_ACCESS_TOKEN_SECRET});
}

# Set whether we want staging or not
$c->staging(0);

p $c;
my $bug = $c->model('Bug')->by_id($public_bug);

say "Bug representation";

p $bug->title;
# p $bug->tasks;
# p $bug->date_created;
# p $bug->watches;
# my $bugtask =
#   first { $_->{bug_target_name} =~ /ubuntu-advantage|(Ubuntu)/ } @{$bug->tasks};
# # p $bugtask;
# my $person = $c->model('Person')->by_name('~adam-stokes');
# p $person;
# p $person->ppas;
