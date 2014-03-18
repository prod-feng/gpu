#!/bin/bash

while [ 1 = 1 ]; do
   read input
   result=$?
   if [ $result != 0 ]; then
      end=true
      break
   fi
   echo begin                  # begin load report

   perl $SGE_ROOT/util/resources/loadsensors/nvidia-loadsensors.pl 

   echo end                    # end load report
done
exit 0 
