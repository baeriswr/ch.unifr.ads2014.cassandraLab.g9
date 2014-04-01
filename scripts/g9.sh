#!/bin/bash

#sed -i 's#\t#<#g' movies_dump.txt #tab :-(
file=$(cat "../movies_dump.txt")


rm -f group9.txt
while IFS='<' read year title rating genres actors
 do  
  if [[ $year -gt 1975 && $year -lt 1996 ]] #1976 - 1995
   then
    #group9="$group9 \n $year<$title<$rating<$genres<$actors"
    echo "$year<$title<$rating<$genres<$actors" >> ../group9.txt
  fi
 done <<< "$file"
 
 #echo -e $group9 > group9.txt
 
exit 0
