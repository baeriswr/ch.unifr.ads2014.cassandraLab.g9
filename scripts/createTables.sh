#!/bin/bash

cqlFile="cql/createTables.cql"
cql="
USE group9;
CREATE TABLE MOVIELOOKUP (title varchar PRIMARY KEY,description varchar);
CREATE TABLE TOPMOVIES (genre varchar PRIMARY KEY, title varchar, rating float);
CREATE TABLE TOPACTORS (actor varchar PRIMARY KEY,popularity int);
CREATE TABLE ROLES (i int PRIMARY KEY, actor varchar ,title varchar);
"

echo $cql | sed 's/\n//g' > $cqlFile

cqlsh -f "$cqlFile" 54.185.30.189 

exit 0

