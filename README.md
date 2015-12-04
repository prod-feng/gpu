gpu
===

Tool for GPU & SGE.

load sensors of SGE for GPU cluster. Need to set a consumable named"ngpus" first. It can give users an easy way to check and list the GPU resouces of the cluster.

gload_sensor.sh and nvidia-loadsensors.pl are load sensor scripts for SGE. 

gpustat.pl can be set as regular command and put it $PATH.

Users can run gpustat.pl

>./gpustat.pl
>HOSTNAME                ARCH         NCPU  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS  NGPUS  SLOTS  GLOAD  GMEM
>-----------------------------------------------------------------------------------------------------------
>global                  -               -     -       -       -       -       -    -     -      -      -   
>node100                 linux-x64      12  8.72   23.6G    2.2G   11.4G   17.9M    1     2     1.98   131MB 
>node101                 linux-x64      12  8.66   23.6G    1.5G   11.4G   14.8M    2     2     1.98   130MB 
 
As in the file "output".

Developed by Perl and Bash.

