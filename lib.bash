#!/bin/bash
# Automatically combined bash-lib, see http://172.17.101.90/divibib-betrieb/ssh-control

term=${TERM:-xterm-256color}
_color_text() {
    [ -z "$1" ] && return
    echo -n "$1"
    tput -T$term sgr0;
}
black() { tput -T$term setaf 0; _color_text "$@"; }
red() { tput -T$term setaf 1; _color_text "$@"; }
green() { tput -T$term setaf 2; _color_text "$@"; }
yellow() { tput -T$term setaf 3; _color_text "$@"; }
blue() { tput -T$term setaf 4; _color_text "$@"; }
magenta() { tput -T$term setaf 5; _color_text "$@"; }
cyan() { tput -T$term setaf 6; _color_text "$@"; }
white() { tput -T$term setaf 7; _color_text "$@"; }
bg_black() { tput -T$term setab 0; _color_text "$@"; }
bg_red() { tput -T$term setab 1; _color_text "$@"; }
bg_green() { tput -T$term setab 2; _color_text "$@"; }
bg_yellow() { tput -T$term setab 3; _color_text "$@"; }
bg_blue() { tput -T$term setab 4; _color_text "$@"; }
bg_magenta() { tput -T$term setab 5; _color_text "$@"; }
bg_cyan() { tput -T$term setab 6; _color_text "$@"; }
bg_white() { tput -T$term setab 7; _color_text "$@"; }
bold() { tput -T$term bold; _color_text "$@"; }
underline() { tput -T$term smul; _color_text "$@"; }
inverse() { tput -T$term rev; _color_text "$@"; }
dim() { tput -T$term dim; _color_text "$@"; }
reset() { tput -T$term sgr0; }
uncolor() {
  sed -r "s/\x1b\[([0-9]{1,2}(;[0-9]{1,2})?)?m//g" <<< $1
}
[ -n "${_log_level[DEBUG]}" ] && return 0
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
declare -ar _log_detect=(DEBUG INFO NOTICE WARN WARNING HEADING ERR ERROR CRIT CRITICAL ALERT EMERG EMERGENCY)
declare -A _log_level
_log_level[DEBUG]=10
_log_level[INFO]=20
_log_level[NOTICE]=25
_log_level[MARK]=25
_log_level[WARN]=30
_log_level[WARNING]=30
_log_level[HEADING]=35
_log_level[ERR]=40
_log_level[ERROR]=40
_log_level[CRIT]=50
_log_level[CRITICAL]=50
_log_level[ALERT]=60
_log_level[EMERG]=70
_log_level[EMERGENCY]=70
declare -r _log_level
declare -A _log_color
_log_color[DEBUG]="$(dim)"
_log_color[INFO]=""
_log_color[NOTICE]="$(green)"
_log_color[MARK]="$(bg_yellow)$(black)$(bold)"
_log_color[WARN]="$(yellow)"
_log_color[WARNING]="$(yellow)"
_log_color[HEADING]="$(cyan)$(inverse)"
_log_color[ERR]="$(red)"
_log_color[ERROR]="$(red)"
_log_color[CRIT]="$(red)$(bold)"
_log_color[CRITICAL]="$(red)$(bold)"
_log_color[ALERT]="$(red)$(bold)$(inverse)"
_log_color[EMERG]="$(red)$(inverse)"
_log_color[EMERGENCY]="$(red)$(inverse)"
declare -r _log_color
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
_log_auto[WARNING]="\b(WARNING|MISSING)\b"
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
LOG_TAG=${LOG_TAG:-$(basename -- "$0")}
LOG_DATE_FORMAT=${LOG_DATE_FORMAT:-"+%Y-%m-%d %H:%M:%S"}
declare -u LOG_LEVEL=${LOG_LEVEL:-INFO}
trap '7>&-' EXIT
if [ -z "$LOG_CONSOLE" ] && [ -z "$LOG_FILE" ] && [ -z "$SYSLOG_FACILITY" ]; then
    LOG_CONSOLE='STDERR'
fi
if [ -n "$LOG_CONSOLE" ] &&[ "$LOG_CONSOLE" != "STDOUT" ] && [ "$LOG_CONSOLE" != "STDERR" ]; then
    echo $(red "Console output to $LOG_CONSOLE undefined, only STDOUT or STDERR are allowed.") >&2
    echo "Logging to STDERR by default." >&2
    LOG_CONSOLE='STDERR'
fi
if [ -n "$LOG_FILE" ] && [ -n "$SYSLOG_FACILITY" ]; then
    echo $(red "You must specify a LOG_FILE path or SYSLOG_FACILITY name, but not both.") >&2
    echo "Logging to STDERR by default." >&2
    unset LOG_FILE
    unset SYSLOG_FACILITY
    LOG_CONSOLE='STDERR'
fi
log_init() {
    if [ -n "$LOG_FILE" ]; then
        if [ ! -r "$LOG_FILE" ]; then
            touch "$LOG_FILE" 2>&1
            if [ $? -ne 0 ]; then
                echo $(red "Could not create $LOG_FILE.") >&2
                echo "Logging to STDERR by default." >&2
                unset LOG_FILE
                LOG_CONSOLE='STDERR'
            fi
        fi
        exec 7>> $LOG_FILE
    fi
}
log_init
if [ -z "$LOG_FILE" ] && [ -n "$SYSLOG_FACILITY" ]; then
    if [[ "$SYSLOG_FACILITY" != local[0-7] ]]; then
        red "Only facilities local0 through local7 are supported for syslog." >&2
        red "Logging to local0 by default." >&2
        SYSLOG_FACILITY='local0'
    fi
    SYSLOG_FACILITY=$SYSLOG_FACILITY
fi
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
log () {
    if [ -z "${_log_level[$LOG_LEVEL]}" ]; then
        echo $(red "\"$LOG_LEVEL\" is not a valid LOG_LEVEL at $LOG_TAG line ${BASH_LINENO[0]}. Defaulting to \"INFO\".") >&2
        LOG_LEVEL="INFO"
    fi
    if [ -e "$LOG_FILE" ]; then
        if [ -n "$LOG_ROTATE_TIME" ]; then
            local file_date=$(date -d "$(stat -c %y $LOG_FILE)" ${_log_rotate_time[$LOG_ROTATE_TIME]})
            local today=$(date ${_log_rotate_time[$LOG_ROTATE_TIME]})
            if [ "$file_date" != "$today" ]; then
                mv "$LOG_FILE" "$LOG_FILE.$file_date"
                [ -n "$LOG_ROTATE_COMPRESS" ] && gzip -q --best "$LOG_FILE.$file_date"
                log_init
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
                log_init
            fi
        fi
    fi
    declare -u message_level=${1:-AUTO}
    if [ ! "$message_level" = "AUTO" ] && [ -z "${_log_level[$1]}" ]; then
        echo $(red "\"${message_level}\" is not a valid message log level at $LOG_TAG line ${BASH_LINENO[0]}. ") >&2
        exit 1
    fi
    if [ -n "$2" ]; then
        _log "$1" "$2"
    else
        while read line
        do
            _log "$1" "$line"
        done < /dev/stdin
    fi
}
_log() {
    IFS=$'\n'
    local message=$( sed 's/^[A-Z*] //' <<< $2)
    local message_date
    message_date=$(date "${LOG_DATE_FORMAT}")
    declare -u message_level=${1:-AUTO}
    if [ "$message_level" = "AUTO" ]; then
        declare -u message_check=$message
        for i in "${_log_detect[@]}"
        do
            if [[ "$message_check" =~ ${_log_auto[$i]} ]]; then
                message_level=$i
            fi
        done
        if [ "$message_level" = "AUTO" ]; then
            message_level="DEBUG"
        fi
    fi
    local max_log_level=${_log_level[$LOG_LEVEL]}
    if [ ${_log_level[$message_level]} -ge $max_log_level ]; then
        if [ -n "$SYSLOG_FACILITY" ]; then
            for line in $message; do
                logger -i \
                    -t "$LOG_TAG" \
                    -p "${SYSLOG_FACILITY}.${_syslog_severity[$message_level]}" \
                    "$message_level: $line"
            done
        else
            for line in $message; do
                [ "$message_level" = "HEADING" ] && printf -v line "%-80s" $line
                printf -v output "${_log_color[$message_level]}%s %s[%s] %s: %s$(reset)" \
                    "$message_date" \
                    "$LOG_TAG" \
                    "$$" \
                    "$message_level" \
                    "$line"
                [ -n "$LOG_FILE" ] && echo "$output" >&7
                if [ -n "$LOG_CONSOLE" ]; then
                    [ "$LOG_CONSOLE" = "STDERR" ] && echo "$output" >&2
                    if [ "$LOG_CONSOLE" = "STDOUT" ]; then
                        printf "[%3s] %s\n" "$message_level" "${_log_color[$message_level]}$line$(reset)"
                    fi
                fi
            done
        fi
    fi
}
log_exit() {
    if [ "$#" -lt 2 ]; then
        log ALERT "parameter missing. Usage: log_exit <level> <message> [<code>]"
        exit 1
    fi
    log "$1" "$2"
    local code="${3:-1}"
    exit "$code"
}
log_cmd() {
    [ "$#" -lt 1 ] && log_exit ALERT "parameter missing. Usage: log_cmd <cmd> [<args>...]"
    local cmd=$1
    log INFO "calling: $@"
    exec 5>&1
    result=$(eval $(printf "%q " "$@") |& tee >/dev/fd/5 >(log) )
    exec 5>&-
    if [ $? -eq 0 ]; then
        log INFO "$cmd call succeeded"
    else
        log ERROR "$cmd exited with return code $?"
    fi
    return $?
}
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
lock() {
    [ "$#" -ne 1 ] && log_exit ALERT "incorrect library call use: lock <lockfile>"
    local lockfile="$1"
    echo $$ > "$lockfile.$$" 2>/dev/null || log_exit ALERT "failed to create PID lockfile: $lockfile.$$"
    if [ -e "$lockfile" ] ; then
        pid=$(cat "$lockfile" || log_exit ALERT "could not read lockfile $lockfile")
        kill -0 "$pid" 2>/dev/null || rm -f "$lockfile" || log_exit ALERT "failed to remove lockfile: $lockfile"
    fi
    while ! ln "$lockfile.$$" "$lockfile" 2>/dev/null
    do
        log INFO "...waiting for lock $lockfile"
        sleep 10
    done
    trap 'unlock $lockfile' EXIT
    return 0
}
exit_lock() {
    [ "$#" -lt 1 ] && log_exit ALERT "incorrect library call use: exit_lock <lockfile> [<error message>] [<exit code>]"
    local lockfile="$1"
    local default="Stop processing because this is locked in $lockfile by $pid"
    local message="${2:-$default}"
    local exit_code="$3"
    if [ -e "$lockfile" ] ; then
        pid=$(cat "$lockfile" || log_exit ALERT "could not read lockfile $lockfile" "$exit_code")
        log_exit NOTICE "$message"
    fi
    lock "$lockfile"
    return $?
}
unlock() {
    [ "$#" -ne 1 ] && log_exit ALERT "incorrect library call use: unlock <lockfile>"
    local lockfile="$1"
    trap - EXIT
    rm -f "$lockfile.$$" || log_exit ALERT "failed to remove PID lockfile: $lockfile.$$"
    if [ -e "$lockfile" ] ; then
        pid=$(cat "$lockfile" || log_exit ALERT "could not read lockfile $lockfile")
        if [ "$pid" -eq "$$" ]; then
            rm -f "$lockfile" || log_exit ALERT "failed to remove lockfile: $lockfile"
        else
            log_exit ALERT "could not remove lockfile because it is set from another process"
        fi
    fi
    return 0
}
