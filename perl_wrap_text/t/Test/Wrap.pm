#!/usr/bin/perl

use strict;
use warnings;

package Test::Wrap;
use base qw(Test::Class);
use Test::Most;
use File::Temp;
use Data::Dumper;
use Wrap;

sub test_wrap_short_string : Tests {
  my $input = "foo bar";
  do_test($input,$input);
}

sub test_wrap_short2_string : Tests {
  my $input = "too foo bar";
  do_test($input,$input);
}

sub test_wrap_long_string : Tests {
  my $input = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz acc fffff";
  my $expected = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz\nacc fffff"; 
  do_test($input, $expected);
}

sub test_wrap_long_string_78 : Tests {
  my $input = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz acc fffff";
  my $expected = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h\nhyhyyyyhyhyhyyhaz acc fffff"; 
  do_test($input, $expected,78);
}

sub test_wrap_a_very_long_string : Tests {
  my $input = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz acc ffffftoo foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz acc fffff";
  my $expected = "too foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyhyhyhyyhaz\nacc ffffftoo foo bar dqsdqsdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h\nhyhyyyyhyhyhyyhaz acc fffff"; 
  do_test($input, $expected,80);
}

sub test_wrap_long_string_with_many_spaces : Tests {
  my $input = "too foo bar dqsd sdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyh          acc fffff";
  my $expected = "too foo bar dqsd sdqsd qsfqsdffqsdfdeazeazfsfsf fsd ggrerge h hyhyyyyh\nacc fffff"; 
  do_test($input, $expected);
}

sub do_test {
  #Given
  my $input = shift;
  my $expected = shift;
  my $length = shift || 80 ;
  #When
  my $wrap = Wrap->new();
  my $output = $wrap->wrap($input,$length);
  #Then
  is($output, $expected);
}
1;
