#!/bin/bash

cqlFile="cql/roles.cql"
rm -f $cqlFile
file=$(cat "../group9.txt")
cql="use group9;"
i=1;
while IFS='<' read year title rating genres actors
 do
  actorList=$(echo $actors | sed 's#,# #g')
  for a in $actorList
   do
    cql="$cql \nINSERT INTO ROLES (i, actor, title) VALUES ($i, '$a', '$title');"
	((i++))
   done    
 done <<< "$file"


echo -e "$cql" | sed '/^$/d'  >> $cqlFile


#cqlsh -f "$cqlFile" 54.185.30.189 

exit 0