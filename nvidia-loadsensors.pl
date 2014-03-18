#!/bin/env perl
#
## Check available GPUs. Feng
#

use File::Basename;
#You might need to update the appropriate info here ...
my $ARCH=`$SGE_ROOT/util/arch`;
my $HOST=`$SGE_ROOT/utilbin/linux-x64/gethostname -name`;
my $ngpu=`nvidia-smi -L|wc -l`;

chomp($ARCH); chomp($HOST);


my @nodes=`nvidia-smi -q -x`;;


my $mem=0;
my $gpu=0;
my $line;
my $res=0;
my $found=0;

foreach $node (@nodes)
{
  my $temp1;
  my $temp2;
  my $numc;
  my $numg;
  if($node=~/gpu id/)
  {
    $found++;
    chomp($node);
# Remember the line info.
    $line=$node;
# Reset the flag for the resource info.
    $res=0;

  }elsif(($node=~/<used>/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    ($temp1,$numg)=split(/>/,$node);
    ($numg,$temp1)=split(/</,$numg);
    ($numg,$temp1)=split(/ /,$numg);
    $mem+=($numg);
  }elsif(($node=~/<gpu_util>/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    ($temp2,$numc)=split(/>/,$node);
    ($numc,$temp2)=split(/%/,$numc);

    $gpu+=int($numc); #/$ngpu);
  }
}
# Print out last line
$gpuld=$gpu/100.0;
printf("$HOST:gload:$gpuld\n");
printf("$HOST:gmem:${mem}MB\n");
