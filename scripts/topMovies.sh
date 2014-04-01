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
    genresList=$(echo $genres | sed 's#|# #g')
    for g in $genresList
     do	
	  #cql="$cql \n INSERT INTO TOPMOVIES (i, title, genre, rating) VALUES ($i, '$title', '$g', $rating);"
	  gL="$gL\n$g<$rating<$title"
	 ((i++))	  
     done
   else
	  #cql="$cql \n INSERT INTO TOPMOVIES (i, title, genre, rating) VALUES ($i, '$title', 'nothing', $rating);"
	  gL="$gL\nnothing<$rating<$title"
	  ((i++))
  fi

 done <<< "$file"
 
gL=$(echo -e "$gL" | sort | sed '/^$/d' )
genreB=""
while IFS='<' read genre rating title
do
if [ "$genre" == "$genreB" ]
 then
  topCurrent="$genre<$rating<$title"
 else
  genreB=$genre
  topCurrent="$genre<$rating<$title"  
  collection="$collection\n$topCurrent"
fi
done <<< "$gL"


collection=$(echo -e $collection | sed '/^$/d') #:-(
while IFS='<' read genre rating title
 do
  cql="$cql \n INSERT INTO TOPMOVIES (genre, title, rating) VALUES ('$genre', '$title', $rating);"
 done <<< "$collection"



echo -e "$cql" | sed '/^$/d'  >> $cqlFile


cqlsh -f "$cqlFile" 54.185.30.189 

exit 0