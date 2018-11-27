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
    lib_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
    conv=""
    if [ -e $lib_dir/csv2html ]; then
        conv="$lib_dir/csv2html"
    elif [ -e $lib_dir/../bin/csv2html ]; then
        conv="$lib_dir/../bin/csv2html"
    else
        log_exit ALERT "Could not find csv2xls, please include it from the bash-lib"
    fi
    if [ -z "$1" ] && [ ! -t 0 ]; then
        cat /dev/stdin | $conv
    else
        echo "$@" | $conv
    fi
}

csv2xls() {
    [ $# -lt 1 ] && log_exit ALERT "This only writes to file, so a file has to be given in csv2xls"
    perl -e 'use Spreadsheet::WriteExcel;' 2>/dev/null || log_exit ALERT "Please use install to get the required bash-lib tools like Spreadsheet::WriteExcel"
    lib_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
    conv=""
    if [ -e $lib_dir/csv2xls ]; then
        conv="$lib_dir/csv2xls"
    elif [ -e $lib_dir/../bin/csv2xls ]; then
        conv="$lib_dir/../bin/csv2xls"
    else
        log_exit ALERT "Could not find csv2xls, please include it from the bash-lib"
    fi
    xlsfile=$1
    csvfile=$(mktemp)
    if [ -z "$2" ] && [ ! -t 0 ]; then
        cat /dev/stdin >$csvfile
    else
        echo "${@:2}" >$csvfile
    fi
    winfile=$(mktemp)
    iconv -t windows-1252 -f utf-8 $csvfile -o $winfile
    $conv -i $winfile -o $xlsfile -h
    log INFO "generated Excel with $(du -h "$xlsfile" | cut -f1)B"
    rm $csvfile $winfile
}
