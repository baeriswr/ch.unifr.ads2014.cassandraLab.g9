#!/bin/bash

cqlFile="cql/clean.cql"
cql="
USE group9;
DROP TABLE MOVIELOOKUP;
DROP TABLE TOPMOVIES;
DROP TABLE TOPACTORS;
DROP TABLE ROLES;
"

echo $cql | sed 's/\n//g' > $cqlFile


cqlsh -f $cqlFile 54.185.30.189 

rm cql/*.cql


exit 0