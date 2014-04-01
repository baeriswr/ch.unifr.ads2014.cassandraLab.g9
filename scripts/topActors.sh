#!/bin/bash

cqlFile=cql/topActors.cql
rm -f $cqlFile
file=$(cat "../group9.txt")
cql="use group9;"
while IFS='<' read year title rating genres actors
 do
  actorsList="$actorsList\n$actors" 
 done <<< "$file"

actorsList=$(echo -e "$actorsList" | sed 's/, /\n/g')
actorsListUniq=$(echo "$actorsList" | sort -u | sed '/^$/d')

while read line
 do
 popularity=$(echo "$actorsList" | grep "$line" | wc -l | sed 's# ##g')
 cql="$cql \n INSERT INTO TOPACTORS (actor, popularity) VALUES ('$line', $popularity);"
 done <<< "$actorsListUniq"
  
echo -e "$cql" | sed '/^$/d'  >> $cqlFile

cqlsh -f "$cqlFile" 54.185.30.189 

exit 0