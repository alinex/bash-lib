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
    if [ -n "$PGLOG" ] && [ "$PGLOG" != 0 ] ; then
        log_cmd psql -Atc "$1"
    else
        psql -Atc "$1"
    fi
}

psql_csv() {
    [ $# -ne 1 ] && log_exit ALERT "The SQL command parameter is needed in call to psql_exec"
    sql="COPY ($1) TO STDOUT DELIMITER ',' CSV HEADER"
    if [ -n "$PGLOG" ] && [ "$PGLOG" != 0 ]; then
        log_cmd psql -Ac "$sql"
    else
        psql -Ac "$sql"
    fi
}

csv2html() {
    local header=true
    local cell=th
    echo "<table>"
    if [ -z "$1" ] && [ ! -t 0 ]; then
        cat /dev/stdin \
        | gawk -v RS='"' 'NR % 2 == 0 { gsub(/\n/, "<br/>") } { printf("%s%s", $0, RT) }' \
        | while read line; do
            echo "<tr><$cell>${line}</$cell></tr>" \
            | sed -r "s/\"?,\"?/<\/$cell><$cell>/g;s/\"\"/\"/g"
            if $header; then
                cell=td
                header=false
            fi
        done
    else
        echo "$@" \
        | gawk -v RS='"' 'NR % 2 == 0 { gsub(/\n/, "<br/>") } { printf("%s%s", $0, RT) }' \
        | while read -r line; do
            echo "<tr><$cell>${line}</$cell></tr>" \
            | sed -r "s/\"?,\"?/<\/$cell><$cell>/g;s/\"\"/\"/g"
            if $header; then
                cell=td
                header=false
            fi
        done
    fi
    echo "</table>"
}