#!/usr/bin/perl
# treeps -- show ps(1) as process hierarchy -- v1.0 erco@seriss.com 07/08/14
my %p; # Global array of pid info
sub PrintLineage($$) {    # Print proc lineage
  my ($pid, $indent) = @_;
  printf("%s |_ %-8d %s\n", $indent, $pid, $p{$pid}{cmd}); # print
  foreach my $kpid (sort {$a<=>$b} @{ $p{$pid}{kids} } ) {  # loop thru kids
    PrintLineage($kpid, "   $indent");                       # Recurse into kids
  }
}
# MAIN
open(FD, "ps axo ppid,pid,command|");
while ( <FD> ) { # Read lines of output
  my ($ppid,$pid,$cmd) = ( $_ =~ m/(\S+)\s+(\S+)\s(.*)/ );  # parse ps(1) lines
  $p{$pid}{cmd} = $cmd;
  # $p{$pid}{kids} = (); <- this line is not needed and can cause incorrect output
  push(@{ $p{$ppid}{kids} }, $pid); # Add our pid to parent's kid
}
PrintLineage(1, "");     # recurse to print lineage starting with pid 1
