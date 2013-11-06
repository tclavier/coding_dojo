package Watchdog;

use strict;
use warnings;

use Data::Dumper;

sub new {
  my $classname = shift;
  my $self      = {};
  bless( $self, $classname );

  $self->{'lsb_distributor'} = `lsb_release -i`;
  $self->{'lsb_distributor'} =~ s/Distributor ID:\s+//;
  chomp $self->{'lsb_distributor'} ;

  return $self;
}


sub nameToProcname {
  my $self = shift;
  my $name = shift;

  if ($self->{'lsb_distributor'} eq "Debian") {
    return $name;
  } else {
    return "httpd";
  }

}

sub memory { 
  my $self = shift;
  my $process = shift;
  my $psoutput = shift;
  my $memory = 0;

  my $realProcess = $self->nameToProcname($process);

  foreach my $line (split(/\n/, $psoutput)) {
    if ($line =~ /(?:\S+\s+){4}(\w+)\s+.*$realProcess/) {
      $memory = $1;
    }
  }
  return $memory;
}

1;
