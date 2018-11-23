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

psql_csv() {
    [ $# -ne 1 ] && log_exit ALERT "The SQL command parameter is needed in call to psql_exec"
    sql="COPY ($1) TO STDOUT DELIMITER ',' CSV"
    if [ -n "$PGLOG" ]; then
        log_cmd psql -Ac "$1"
    else
        psql -Ac "$1"
    fi
}
