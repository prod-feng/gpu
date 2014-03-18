#!/usr/bin/perl -w
#
## Check available GPUs.
#
use File::Basename;

my @nodes=`qhost -F`;;
chomp($nodes[0]);
chomp($nodes[1]);
chomp($nodes[2]);
printf("$nodes[0]  NGPUS  SLOTS  GLOAD  GMEM\n");
printf("$nodes[1]----------------------------\n");
printf("$nodes[2]    -     -      -      -   \n");

my $gpu=0;
my $cpu=0;
my $gload=0;
my $gmem=0;
my $line;
 my $res=0;
foreach $node (@nodes)
{
  my $found=0;
  if($node=~/node/)
  {
    $found=1;
    chomp($node);
    if($res ge 4){
      printf("$line    $gpu    ");
      printf("%2d     %3.2f  %6s \n",$cpu,$gload,$gmem);
    }
# Remember the line info.
    $line=$node;
# Reset the flag for the resource info.
    $res=0;

  }elsif(($node=~/ngpus/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    (my $temp1,my $numg)=split(/=/,$node);
    $gpu=int($numg);
  }elsif(($node=~/slots/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    (my $temp2,my $numc)=split(/=/,$node);
    $cpu=int($numc);
  }
  elsif(($node=~/gload/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    (my $temp2,my $numc)=split(/=/,$node);
    $gload=($numc);
  }
  elsif(($node=~/gmem/))
  {
    $res++;
    chomp($node);$node =~ s/\s+//;
    (my $temp2,my $numc)=split(/=/,$node);
    $gmem=($numc);
  }
}
# Print out last line
printf("$line    $gpu    ");
printf("%2d     %3.2f  %6s \n",$cpu,$gload,$gmem);

