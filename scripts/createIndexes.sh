#!/bin/bash

cqlFile="cql/createIndexes.cql"
rm -f $cqlFile


cql="USE group9;
CREATE INDEX ON TOPMOVIES(title);
"


echo -e "$cql" | sed '/^$/d'  >> $cqlFile

cqlsh -f "$cqlFile" 54.185.30.189 

exit 0