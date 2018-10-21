#!/bin/bash

# Setup

# DB_USER
# DB_PASSWORD
# DB_HOST
# DB_PORT
# DB_DATABASE

# Commands

# psql_field <query>

# psql_record <query>
# psql_records <query>
# psql_exec <query>


vartest=`psql -X -A -d $dbname -U $username -h localhost -p 5432 -t -c "SELECT gid FROM testtable WHERE aid='1'"`

# ------

DB_NAME=$1
psql -d ${DB_NAME} -At -c "select rno, studname, studclass from tbl_students" \
    | while read -a Record ; do
    rno=${Record[0]}
    studname=${Record[1]}
    studclass=${Record[2]}

    echo "${rno} ${studname} ${studclass}"
done