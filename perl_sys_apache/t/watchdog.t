#!/usr/bin/env perl 

use strict;
use warnings;

use lib 't';
use Test::Watchdog;

Test::Class->runtests;

1;
