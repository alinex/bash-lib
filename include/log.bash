#!/bin/bash

# Log library
#
# http://172.17.101.90/divibib-betrieb/bash-lib/blob/master/doc/log.md
#
# Usage:
#
# source ../bash-lib/include/log.bash  # load functions
# log $message $file

#[ -n "${_log_level[DEBUG]}" ] && return 0 # library already loaded

source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/colors.bash" # load color methods

declare -ar _log_detect=(DEBUG INFO NOTICE WARN WARNING HEADING ERR ERROR CRIT CRITICAL ALERT EMERG EMERGENCY)

# Log levels are taken from python and RFC 5424.
declare -A _log_level
# These are the python numeric log levels, with the addition
# of RFC 5424 levels. The RFC 5424 levels have been given
# numbers to sequence them with the python levels.
_log_level[DEBUG]=10
_log_level[INFO]=20
_log_level[NOTICE]=25   # RFC 5424 specific
_log_level[MARK]=25     # own extension
_log_level[WARN]=30
_log_level[WARNING]=30
_log_level[HEADING]=35  # own extension
_log_level[ERR]=40
_log_level[ERROR]=40
_log_level[CRIT]=50
_log_level[CRITICAL]=50
_log_level[ALERT]=60    # RFC 5424 specific
_log_level[EMERG]=70    # RFC 5424 specific
_log_level[EMERGENCY]=70 # RFC 5424 specific
declare -r _log_level

declare -A _log_color
# These are the python numeric log levels, with the addition
# of RFC 5424 levels. The RFC 5424 levels have been given
# numbers to sequence them with the python levels.
_log_color[DEBUG]="$(dim)"
_log_color[INFO]=""
_log_color[NOTICE]="$(green)" # RFC 5424 specific
_log_color[MARK]="$(bg_yellow)$(black)$(bold)"
_log_color[WARN]="$(yellow)"
_log_color[WARNING]="$(yellow)"
_log_color[HEADING]="$(cyan)$(inverse)"
_log_color[ERR]="$(red)"
_log_color[ERROR]="$(red)"
_log_color[CRIT]="$(red)$(bold)"
_log_color[CRITICAL]="$(red)$(bold)"
_log_color[ALERT]="$(red)$(bold)$(inverse)" # RFC 5424 specific
_log_color[EMERG]="$(bg_red)$(bold)$(white)" # RFC 5424 specific
_log_color[EMERGENCY]="$(bg_red)$(bold)$(white)" # RFC 5424 specific
declare -r _log_color

# These are the RFC 5424 numeric severity levels.
declare -A _syslog_severity
_syslog_severity[DEBUG]=7
_syslog_severity[INFO]=6
_syslog_severity[NOTICE]=5
_syslog_severity[MARK]=5
_syslog_severity[WARN]=4
_syslog_severity[WARNING]=4
_syslog_severity[HEADING]=4
_syslog_severity[ERR]=3
_syslog_severity[ERROR]=3
_syslog_severity[CRIT]=2
_syslog_severity[CRITICAL]=2
_syslog_severity[ALERT]=1
_syslog_severity[EMERG]=0
_syslog_severity[EMERGENCY]=0
declare -r _syslog_severity

declare -A _log_auto
_log_auto[DEBUG]="\b(DEBUG|COPYRIGHT|WARRANTY)\b|^\s*(AT|AFTER) "
_log_auto[INFO]="\b(INFO|(START|CALL)(ING)?|TRANSMITTED)\b"
_log_auto[NOTICE]="\b(NOTICE|ERFOLGREICH|SUCCEEDED|FINISHED)\b"
_log_auto[MARK]="!!!"
_log_auto[WARN]="\b(WARN)\b"
_log_auto[WARNING]="\b(WARNING|MISSING|UNKNOWN)\b"
_log_auto[HEADING]="\b(HEADING)\b"
_log_auto[ERR]="\b(ERR)\b"
_log_auto[ERROR]="\b(ERROR|FEHLERHAFT|FAILED)\b"
_log_auto[CRIT]="\b(CRIT)\b"
_log_auto[CRITICAL]="\b(CRITICAL|FATAL)\b"
_log_auto[ALERT]="\b(ALERT|EXCEPTION)\b"
_log_auto[EMERG]="\b(EMERG)\b"
_log_auto[EMERGENCY]="\b(EMERGENCY)\b"
declare -r _log_auto

declare -A _log_rotate_time
_log_rotate_time[DAILY]="+%Y-%m-%d"
_log_rotate_time[WEEKLY]="+%Y_week_%W"
_log_rotate_time[MONTHLY]="+%Y-%m"
declare -r _log_rotate_time

# Set defaults if variables have not been specified
LOG_LEVEL_DEFAULT=${LOG_LEVEL_DEFAULT:-AUTO}
LOG_TAG=${LOG_TAG:-$(basename -- "$0")}
LOG_DATE_FORMAT=${LOG_DATE_FORMAT:-"+%Y-%m-%d %H:%M:%S"}
declare -u LOG_LEVEL=${LOG_LEVEL:-INFO}

# close descriptor #6 and #7 used for output
trap '7>&-' EXIT

# check destination setting
if [ -z "$LOG_CONSOLE" ] && [ -z "$LOG_FILE" ] && [ -z "$SYSLOG_FACILITY" ]; then
    LOG_CONSOLE='SIMPLE' # default setting
fi
if [ -n "$LOG_CONSOLE" ] &&[ "$LOG_CONSOLE" != "SIMPLE" ] && [ "$LOG_CONSOLE" != "FULL" ]; then
    echo $(red "Console output to $LOG_CONSOLE undefined, only SIMPLE or FULL are allowed.") >&2
    echo "Logging in SIMPLE format by default." >&2
    LOG_CONSOLE='SIMPLE'
fi
if [ -n "$LOG_FILE" ] && [ -n "$SYSLOG_FACILITY" ]; then
    echo $(red "You must specify a LOG_FILE path or SYSLOG_FACILITY name, but not both.") >&2
    echo "Logging to console by default." >&2
    unset LOG_FILE
    unset SYSLOG_FACILITY
    LOG_CONSOLE='SIMPLE'
fi

# reinitialize logging (if file is changed)
log_init() {
    # check if file logging is possible
    if [ -n "$LOG_FILE" ]; then
        echo setup log file
        if [ ! -r "$LOG_FILE" ]; then
            touch "$LOG_FILE" 2>&1
            if [ $? -ne 0 ]; then
                echo $(red "Could not create $LOG_FILE.") >&2
                echo "Logging to console by default." >&2
                unset LOG_FILE
                LOG_CONSOLE='SIMPLE'
            fi
        fi
        # set output handle
        exec 7>> $LOG_FILE
    fi
}

# setup syslog
if [ -z "$LOG_FILE" ] && [ -n "$SYSLOG_FACILITY" ]; then
    if [[ "$SYSLOG_FACILITY" != local[0-7] ]]; then
        red "Only facilities local0 through local7 are supported for syslog." >&2
        red "Logging to local0 by default." >&2
        SYSLOG_FACILITY='local0'
    fi
    SYSLOG_FACILITY=$SYSLOG_FACILITY
fi

# check for valid log rotation time
if [ -n "$LOG_ROTATE_TIME" ]; then
    declare -u LOG_ROTATE_TIME
    if [ -z "${_log_rotate_time[$LOG_ROTATE_TIME]}" ]; then
        echo $(red "\"$LOG_ROTATE_TIME\" is not a valid LOG_ROTATE_TIME value at $LOG_TAG line ${BASH_LINENO[0]}. Defaulting to \"DAILY\".") >&2
        LOG_ROTATE_TIME="DAILY"
    fi
    declare -r LOG_ROTATE_TIME
fi

declare -i LOG_ROTATE_SIZE
declare -r LOG_ROTATE_SIZE
declare -i LOG_ROTATE_NUM=${LOG_ROTATE_NUM:-9}
declare -r LOG_ROTATE_NUM

# Usage: log <level> <message>
# With input pipe: log <level>
log () {

    # check for valid log level
    if [ -z "${_log_level[$LOG_LEVEL]}" ]; then

        echo $(red "\"$LOG_LEVEL\" is not a valid LOG_LEVEL at $LOG_TAG line ${BASH_LINENO[0]}. Defaulting to \"INFO\".") >&2
        LOG_LEVEL="INFO"
    fi

    # rotate log files
    if [ -e "$LOG_FILE" ]; then
        if [ -n "$LOG_ROTATE_TIME" ]; then
            local file_date=$(date -d "$(stat -c %y $LOG_FILE)" ${_log_rotate_time[$LOG_ROTATE_TIME]})
            local today=$(date ${_log_rotate_time[$LOG_ROTATE_TIME]})
            if [ "$file_date" != "$today" ]; then
                mv "$LOG_FILE" "$LOG_FILE.$file_date"
                [ -n "$LOG_ROTATE_COMPRESS" ] && gzip -q --best "$LOG_FILE.$file_date"
                # reopen file handle
                #log_init
            fi
        elif [ -n "$LOG_ROTATE_SIZE" ]; then
            local file_size=$(du -b "$LOG_FILE" | tr -s '\t' ' ' | cut -d' ' -f1)
            if [ $file_size -ge $LOG_ROTATE_SIZE ]; then
                for i in `seq $((LOG_ROTATE_NUM-1)) -1 1`; do
                    [ -e "$LOG_FILE.$i" ] && mv "$LOG_FILE.$i" "$LOG_FILE.$((i+1))"
                    [ -e "$LOG_FILE.$i.gz" ] &&  mv "$LOG_FILE.$i.gz" "$LOG_FILE.$((i+1)).gz"
                done
                mv "$LOG_FILE" "$LOG_FILE.1"
                [ -n "$LOG_ROTATE_COMPRESS" ] && gzip -q --best "$LOG_FILE.1"
                # reopen file handle
                #log_init
            fi
        fi
    fi

    declare -u message_level=${1:-$LOG_LEVEL_DEFAULT}
    if [ ! "${message_level:0:4}" = "AUTO" ] && [ -z "${_log_level[$message_level]}" ]; then
        echo $(red "\"${message_level}\" is not a valid message log level at $LOG_TAG line ${BASH_LINENO[0]}. ") >&2
        exit 1
    fi
    if [ "${message_level:0:4}" = "AUTO" ] && [ "${message_level:4:1}" = "_" ] && [ -z "${_log_level[${message_level:5:10}]}" ]; then
        echo $(red "\"${message_level}\" is not a valid auto message log level at $LOG_TAG line ${BASH_LINENO[0]}. ") >&2
        exit 1
    fi

    # open filehandle
    log_init

    if [ -n "$2" ]; then
        # direct input
        _log "$1" "$2"
    else
        # read from pipe
        while read line
        do
            _log "$1" "$line"
        done < /dev/stdin
    fi

    # close filehandle
    exec 7>&-
}

# _log <level> <message>
_log() {

    IFS=$'\n'
    local message=$( sed 's/^\[[[:upper:]]*\] //' <<< $2)
    local message_date
    message_date=$(date "${LOG_DATE_FORMAT}")

    # check message level
    declare -u message_level=${1:-AUTO}
    if [ "${message_level:0:4}" = "AUTO" ]; then
        declare -u message_check=$message
        min=${_log_level[DEBUG]}
        if [ "${message_level:4:1}" = "_" ]; then
            min=${_log_level[${message_level:5:10}]}
        fi
        for i in "${_log_detect[@]}"
        do
            if [[ "$message_check" =~ ${_log_auto[$i]} ]] && [ ${_log_level[$i]} -gt $min ] ; then
                message_level=$i
            fi
        done
        # set default if not matched
        if [ "${message_level:0:4}" = "AUTO" ]; then
            if  [ "${message_level:4:1}" = "_" ]; then
                message_level="${message_level:5:10}"
            else
                message_level="DEBUG"
            fi
        fi
    fi

    local max_log_level=${_log_level[$LOG_LEVEL]}
    if [ ${_log_level[$message_level]} -ge $max_log_level ]; then
        if [ -n "$SYSLOG_FACILITY" ]; then
            for line in $message; do
#                line=$(echo "$line" | tr '\r' '\n')
                logger -i \
                    -t "$LOG_TAG" \
                    -p "${SYSLOG_FACILITY}.${_syslog_severity[$message_level]}" \
                    "$message_level: $line"
            done
        else
            for line in $message; do
#                line=$(echo "$line" | tr '\r' '\n')
                [ "$message_level" = "HEADING" ] && printf -v line "%-80s" $line # fixed length of bg color
                printf -v output "${_log_color[$message_level]}%s %s[%s] %s: %s$(reset)" \
                    "$message_date" \
                    "$LOG_TAG" \
                    "$$" \
                    "$message_level" \
                    "$line"
                [ -n "$LOG_FILE" ] && echo "$output" >&7
                if [ -n "$LOG_CONSOLE" ]; then
                    if [ "$LOG_CONSOLE" = "SIMPLE" ]; then
                        printf -v output "$(black)[%-9s]$(reset) %s" "$message_level" "${_log_color[$message_level]}$line$(reset)"
                    fi
                    echo "$output" >&2
                fi
            done
        fi
    fi
}

# Usage: log_exit <level> <message> [<code>]
log_exit() {
    if [ "$#" -lt 2 ]; then
        log ALERT "parameter missing. Usage: log_exit <level> <message> [<code>]"
        exit 1
    fi
    log "$1" "$2"
    local code="${3:-1}"
    exit "$code"
}

# Usage: log_cmd <cmd> [<args>...]
# Code: from command, too
log_cmd() {
    [ "$#" -lt 1 ] && log_exit ALERT "parameter missing. Usage: log_cmd <cmd> [<args>...]"

    local cmd=$1
    local call=$(printf "%q " "$@")
    log INFO "calling: $call"
    # result=$(eval $(printf "%q " "$@") |& tee >/dev/fd/5 >(log) )

    exec 5>&1 # fd to write to real output
    set -o pipefail
    eval "stdbuf -o0 -e0 $call" |& tee >&5 >(log)
#    ( eval "stdbuf -o0 -e0 $call" 3>&1 1>&2 2>&3 | tee >&5 >(log) ) 3>&1 1>&2 2>&3 | tee >&5 >(log)
#    ( eval "stdbuf -o0 -e0 $call" 3>&1 1>&2 2>&3 | tee >&5 >(log AUTO_WARN) ) 3>&1 1>&2 2>&3 | tee >&5 >(log)
    code=$?
    #code=${PIPESTATUS[0]}
    exec 5>&- # close
    sleep 0.1 # wait for output

    if [ $code -eq 0 ]; then
        log NOTICE "$cmd call succeeded"
    else
        log ERROR "$cmd exited with return code $code"
    fi
    return $code
}
