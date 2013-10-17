package Wrap;

use strict;
use warnings;

use Data::Dumper;

sub new {
  my $classname = shift;
  my $self      = {};
  bless( $self, $classname );
  return $self;
}
sub wrap { 
  my $self = shift;
  my $input = shift;
  my $length = shift || 80;
  my $pos = $length-1;

  if (length($input) <= $length) {
      return $input;
  }

  while ( substr($input,$pos,1) ne " " ) {
   $pos--;
  }

  my $firstpart = substr($input, 0, $pos); 
  my $nextpart = $self->wrap(substr($input, $pos+1), $length);
  $firstpart =~ s/\s+$//;
  $nextpart =~ s/^\s+//;

  my $output = $firstpart . "\n". $nextpart;
  return $output;
}

1;
