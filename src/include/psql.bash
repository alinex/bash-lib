#!/bin/bash

# Log library
#
# http://172.17.101.90/divibib-betrieb/bash-lib/blob/master/doc/psql.md
#
# Usage:
#
# source ../bash-lib/include/psql.bash  # load functions
# log $message $file

#[ -n "${_log_level[DEBUG]}" ] && return 0 # library already loaded

source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/log.bash" # load color methods

export PGCONNECT_TIMEOUT=${PGCONNECT_TIMEOUT:-5}

# exit if database not accessible
psql_exit() {
    log INFO "Testing..."
    result=$(pg_isready)
    if [ $? -eq 0 ]; then
        log NOTICE "PostgreSQL database $result"
    else
        log_exit ALERT "PostgreSQL database $result"
    fi
}

psql_exec() {
    [ $# -ne 1 ] && log_exit ALERT "The SQL command parameter is needed in call to psql_exec"
    if [ -n "$PGLOG" ]; then
        log_cmd psql -Atc "$1"
    else
        psql -Atc "$1"
    fi
}

# vartest=`psql -X -A -d $dbname -U $username -h localhost -p 5432 -t -c "SELECT gid FROM testtable WHERE aid='1'"`
#
# # ------
#
# DB_NAME=$1
# psql -d ${DB_NAME} -At -c "select rno, studname, studclass from tbl_students" \
#     | while read -a Record ; do
#     rno=${Record[0]}
#     studname=${Record[1]}
#     studclass=${Record[2]}
#
#     echo "${rno} ${studname} ${studclass}"
# done