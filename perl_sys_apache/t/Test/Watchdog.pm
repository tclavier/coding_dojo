#!/usr/bin/perl

use strict;
use warnings;

package Test::Watchdog;
use base qw(Test::Class);
use Test::Most;
use File::Temp;
use Data::Dumper;
use Watchdog;

sub test_apache_process_doesnot_exist : Tests {
  my $input = <<EOF;
root     15517  0.0  0.0      0     0 ?        S    12:31   0:00 [kworker/0:0]
tom      15521  0.0  0.0  19712  2120 pts/2    Ss   12:31   0:00 bash
tom      15529  0.1  0.0  17144  1988 pts/2    S+   12:32   0:00 man ps
tom      15543  0.0  0.0   8156   968 pts/2    S+   12:32   0:00 pager -s
tom      15548  0.0  0.0  19100  1324 pts/1    R+   12:32   0:00 ps axu
EOF
  my $watchdog = new Watchdog();

  is($watchdog->memory("apache",$input), 0);
}

sub test_apache_process_exist : Tests {
  my $input = <<EOF;
root     15517  0.0  0.0      0     0 ?        S    12:31   0:00 [kworker/0:0]
tom      15521  0.0  0.0  19712  2120 pts/2    Ss   12:31   0:00 apache2
tom      15529  0.1  0.0  17144  1988 pts/2    S+   12:32   0:00 man ps
tom      15543  0.0  0.0   8156   968 pts/2    S+   12:32   0:00 pager -s
tom      15548  0.0  0.0  19100  1324 pts/1    R+   12:32   0:00 ps axu
EOF
  my $watchdog = new Watchdog();

  is($watchdog->memory("apache",$input), 19712);
}

sub test_another_apache_process_exist : Tests {
  my $input = <<EOF;
root     15517  0.0  0.0      0     0 ?        S    12:31   0:00 [kworker/0:0]
tom      15529  0.1  0.0  17144  1988 pts/2    S+   12:32   0:00 man ps
tom      15543  0.0  0.0   8156   968 pts/2    S+   12:32   0:00 pager -s
tom      15521  0.0  0.0  33061  2120 pts/2    Ss   12:31   0:00 apache2
tom      15548  0.0  0.0  19100  1324 pts/1    R+   12:32   0:00 ps axu
EOF
  my $watchdog = new Watchdog();

  is($watchdog->memory("apache",$input), 33061);
}

sub test_httpd_process_exist_on_centos : Tests {
  my $input = <<EOF;
root     15517  0.0  0.0      0     0 ?        S    12:31   0:00 [kworker/0:0]
tom      15529  0.1  0.0  17144  1988 pts/2    S+   12:32   0:00 man ps
tom      15543  0.0  0.0   8156   968 pts/2    S+   12:32   0:00 pager -s
tom      15521  0.0  0.0  33061  2120 pts/2    Ss   12:31   0:00 httpd
tom      15548  0.0  0.0  19100  1324 pts/1    R+   12:32   0:00 ps axu
EOF
  my $watchdog = new Watchdog();
  $watchdog->{'lsb_distributor'}='CentOS';

  is($watchdog->memory("apache",$input), 33061);
}

sub test_another_httpd_process_exist : Tests {
  my $input = <<EOF;
root     15517  0.0  0.0      0     0 ?        S    12:31   0:00 [kworker/0:0]
tom      15529  0.1  0.0  17144  1988 pts/2    S+   12:32   0:00 man ps
tom      15543  0.0  0.0   8156   968 pts/2    S+   12:32   0:00 pager -s
tom      15521  0.0  0.0  33061  2120 pts/2    Ss   12:31   0:00 httpd
tom      15548  0.0  0.0  19100  1324 pts/1    R+   12:32   0:00 ps axu
EOF
  my $watchdog = new Watchdog();

  is($watchdog->memory("httpd",$input), 33061);
}

sub test_constructor : Tests {

  my $watchdog = new Watchdog();
  is($watchdog->{'lsb_distributor'},'Debian');

}

sub test_name2procname_for_apache_on_centos : Tests {
  my $watchdog = new Watchdog();
  $watchdog->{'lsb_distributor'}='CentOS';
  is($watchdog->nameToProcname("apache2"), "httpd");
}

1;
