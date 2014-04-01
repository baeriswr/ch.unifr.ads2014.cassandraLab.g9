#!/bin/bash

cqlFile="cql/movieLookup.cql"
rm -f cqlFile
file=$(cat "../group9.txt")
cql="use group9;"
while IFS='<' read year title rating genres actors
 do
 cql="$cql \n
INSERT INTO MOVIELOOKUP (title, description) VALUES ('$title', '$title released at $year which is a $genres film with $actors as actors, this film has obtained the rate $rating');"

 done <<< "$file"

echo -e "$cql" | sed '/^$/d'  >> $cqlFile


cqlsh -f "$cqlFile" 54.185.30.189 

exit 0