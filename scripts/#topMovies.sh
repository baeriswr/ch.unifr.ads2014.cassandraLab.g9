#!/bin/bash

cqlFile="cql/topMovies.cql"
rm -f $cqlFile
file=$(cat "../group9.txt")
cql="use group9;"
i=1;
while IFS='<' read year title rating genres actors
 do

  if [ "$genres" != "" ] #sometimes there is no genre...
   then
    genreList=$(echo $genres | sed 's#|# #g')
    for g in $genreList
     do	
	  cql="$cql \n INSERT INTO TOPMOVIES (i, title, genre, rating) VALUES ($i, '$title', '$g', $rating);"
	 ((i++))	  
     done
   else
	  cql="$cql \n INSERT INTO TOPMOVIES (i, title, genre, rating) VALUES ($i, '$title', 'nothing', $rating);"
	  ((i++))
  fi


 done <<< "$file"

echo -e "$cql" | sed '/^$/d'  >> $cqlFile


cqlsh -f "$cqlFile" 54.185.30.189 

exit 0