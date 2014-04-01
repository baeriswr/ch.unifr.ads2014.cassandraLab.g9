#!/bin/bash

function runCQL {
 cqlFile="cql/client.cql"
 echo -e "use group9; $1" > $cqlFile
 cqlsh -f $cqlFile 54.185.30.189 
 exit 0
}


#getMovie title
function getMovie {
 query="select title, description from MOVIELOOKUP where title='$1';"
 runCQL "$query"
 exit 0
}

#getTopMovies genre
function getTopMovies {
 #query="select title, rating from TOPMOVIES WHERE genre='$1' ORDER BY rating DESC LIMIT 30;"
 query="select title, rating from TOPMOVIES WHERE genre='$1';" 
 runCQL "$query"
 exit 0
}

#getTopActors
function getTopActors {
 query="select actor, popularity from TOPACTORS ORDER BY popularity DESC LIMIT 10;"
 runCQL "$query"
 exit 0
}

#addMovie year title rating genres actors
function addMovie {
 year=$1
 title=$2
 rating=$3
 genres=$4
 actors=$5
 
 #MOVIELOOKUP
 query="$query \n
INSERT INTO MOVIELOOKUP (title, description) VALUES ('$title', '$title released at $year which is a $genres film with $actors has obtained the rate $rating');"

 #TOPMOVIES
  if [ "$genres" != "" ] #sometimes there is no genre...
   then
    genreList=$(echo $genres | sed 's#|# #g')
    for g in $genreList
     do	
	  query="$query \n INSERT INTO TOPMOVIES (title, genre, rating) VALUES ('$title', '$g', $rating);"
     done
   else
	  query="$query \n INSERT INTO TOPMOVIES (title, genre, rating) VALUES ('$title', 'nothing', $rating);"
  fi 
 
  #TOPACTORS
  #query="$query \n UPDATE TOPACTORS set popularity = popularity + 1 where actor = '$actor';"
  
  runCQL "$query"
 
 exit 0
}

#deleteMovie title
function deleteMovie {
 title=$1

 #MOVIELOOKUP
 cql="$cql \n DELETE FROM MOVIELOOKUP WHERE title='$title';"

 #TOPMOVIES
 cql="$cql \n DELETE FROM TOPMOVIES WHERE title='$title';"
 
 #TOPACTORS
 cql="$cql \n UPDATE TOPACTORS set popularity = popularity + 1 where actor = '$actor';"
 
 exit 0

}

#getMovie 'title7'
#getTopMovies 'g1'
addMovie '1995' 'title_added' '7' 'g2|g4' 'a1,a9'



exit 0