#!/bin/bash
# Automatically combined bash-lib, see http://172.17.101.90/divibib-betrieb/ssh-control

term=${TERM:-xterm-256color}
_color_text() {
    if [ -z "$1" ] && [ ! -t 0 ]; then
      cat </dev/stdin
      tput -T$term sgr0;
    elif [ -n "$1" ] && [ ! "$1" = "+" ]; then
      echo -n "$@"
      tput -T$term sgr0;
    fi
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
  if [ -z "$1" ] && [ ! -t 0 ]; then
    sed 's/\x1B\[[0-9;]*[a-zA-Z]//g;s/\x1B\x28\x42//g' </dev/stdin
  else
    sed 's/\x1B\[[0-9;]*[a-zA-Z]//g;s/\x1B\x28\x42//g' <<< "$@"
  fi
}
[ -n "${_log_level[DEBUG]}" ] && return 0
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
declare -ar _log_detect=(DEBUG INFO NOTICE WARN MARK WARNING HEADING ERR ERROR CRIT CRITICAL ALERT EMERG EMERGENCY)
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
_log_color[DEBUG]="$(dim +)"
_log_color[INFO]=""
_log_color[NOTICE]="$(green +)"
_log_color[MARK]="$(yellow +)$(inverse +)"
_log_color[WARN]="$(yellow +)"
_log_color[WARNING]="$(yellow +)"
_log_color[HEADING]="$(cyan +)$(inverse +)"
_log_color[ERR]="$(red +)"
_log_color[ERROR]="$(red +)"
_log_color[CRIT]="$(red +)$(bold +)"
_log_color[CRITICAL]="$(red +)$(bold +)"
_log_color[ALERT]="$(red +)$(bold +)$(inverse +)"
_log_color[EMERG]="$(bg_red +)$(bold +)$(white +)"
_log_color[EMERGENCY]="$(bg_red +)$(bold +)$(white +)"
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
_log_auto[MARK]="\b(MARK)\b|!!!"
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
declare -A LOG_AUTO
declare -A _log_rotate_time
_log_rotate_time[DAILY]="+%Y-%m-%d"
_log_rotate_time[WEEKLY]="+%Y_week_%W"
_log_rotate_time[MONTHLY]="+%Y-%m"
declare -r _log_rotate_time
declare -u LOG_LEVEL_DEFAULT=${LOG_LEVEL_DEFAULT:-AUTO}
LOG_TAG=${LOG_TAG:-$(basename -- "$0")}
LOG_DATE_FORMAT=${LOG_DATE_FORMAT:-"+%Y-%m-%d %H:%M:%S"}
declare -u LOG_LEVEL=${LOG_LEVEL:-INFO}
declare -u LOG_CONSOLE
trap '7>&-' EXIT
log_init() {
    if [ -z "$LOG_CONSOLE" ] && [ -z "$LOG_FILE" ] && [ -z "$SYSLOG_FACILITY" ]; then
        LOG_CONSOLE='SIMPLE'
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
    if [ -n "$LOG_FILE" ]; then
        if [ ! -r "$LOG_FILE" ]; then
            mkdir -p $(dirname $LOG_FILE) && touch "$LOG_FILE" 2>&1
            if [ $? -ne 0 ]; then
                echo $(red "Could not create $LOG_FILE.") >&2
                echo "Logging to console by default." >&2
                unset LOG_FILE
                LOG_CONSOLE='SIMPLE'
            fi
        fi
        exec 7>> $LOG_FILE
    fi
}
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
    [ -n "$LOG_FILE" ] && LOG_FILE=$(readlink -m "$LOG_FILE")
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
    log_init
    if [ ! -t 0 ]; then
        while read line; do
            _log "$1" "$line" </dev/null
        done </dev/stdin
    else
        echo "${@:2}" |
        while read -r line; do
            _log "$1" "$line" </dev/null
        done
    fi
    exec 7>&-
}
_log() {
    IFS=$'\n'
    local message=$(uncolor "${@:2}")
    declare -u message_check=$message
    message=$( sed 's/^\[[A-Z][A-Z]* *\] //' <<< "$message" )
    local message_date
    message_date=$(date "${LOG_DATE_FORMAT}")
    declare -u message_level=${1:-AUTO}
    if [ "${message_level:0:4}" = "AUTO" ]; then
        min=${_log_level[DEBUG]}
        if [ "${message_level:4:1}" = "_" ]; then
            min=${_log_level[${message_level:5:10}]}
            message_level="${message_level:5:10}"
        else
            message_level="DEBUG"
        fi
        for i in "${_log_detect[@]}"
        do
            if [[ "$message_check" =~ ${_log_auto[$i]} ]] && [ ${_log_level[$i]} -gt $min ] ; then
                message_level=$i
            fi
            if [ -n "${LOG_AUTO[$i]}" ]; then
                LOG_AUTO[$i]=$( echo ${LOG_AUTO[$i]} | perl -pe 's/(\\[bsSdDwW])|([a-z])/\1\U\2\E/g')
                if [[ "$message_check" =~ ${LOG_AUTO[$i]} ]] && [ ${_log_level[$i]} -gt $min ] ; then
                    message_level=$i
                fi
            fi
        done
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
                    if [ "$LOG_CONSOLE" = "SIMPLE" ]; then
                        printf -v output "$(black +)[%-9s]$(reset) %s" "$message_level" "${_log_color[$message_level]}$line$(reset)"
                    fi
                    echo "$output" >&2
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
    local call=$(printf "%q " "$@")
    log INFO "calling: $call"
    exec 5>&1
    set -o pipefail
    eval "tee >(log) | stdbuf -o0 -e0 $call" </dev/stdin |& tee >&5 >(log)
    code=$?
    exec 5>&-
    sleep 0.1
    if [ $code -eq 0 ]; then
        log NOTICE "$cmd call succeeded"
    else
        log ERROR "$cmd exited with return code $code"
    fi
    return $code
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
    while ! ln "$lockfile.$$" "$lockfile" 2>/dev/null; do
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
[ -n "$OS" ] && return 0
source_dir=$(dirname "${BASH_SOURCE[0]}")
OS=$(uname | tr '[:upper:]' '[:lower:]')
KERNEL=$(uname -r)
MACH=$(uname -m)
if [ "{$OS}" == "windowsnt" ]; then
    OS=Windows
elif [ "{$OS}" == "darwin" ]; then
    OS=Mac
else
    OS=$(uname)
    if [ "${OS}" = "SunOS" ] ; then
        OS=Solaris
        MACH=$(uname -p)
    elif [ "${OS}" = "Linux" ] ; then
        if [ -f /etc/redhat-release ] ; then
            DIST_BASE='RedHat'
            DIST=$(cat /etc/redhat-release | sed s/\ release.*//)
            REV_NAME=$(cat /etc/redhat-release | sed s/.*\(// | sed s/\)//)
            REV=$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)
        elif [ -f /etc/SuSE-release ] ; then
            DIST_BASE='SuSe'
            REV_NAME=$(cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//)
            REV=$(cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //)
        elif [ -f /etc/mandrake-release ] ; then
            DIST_BASE='Mandrake'
            REV_NAME=$(cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//)
            REV=$(cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//)
        elif [ -f /etc/debian_version ] ; then
            DIST_BASE='Debian'
            DIST=$(grep '^DISTRIB_ID' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
            REV_NAME=$(grep '^DISTRIB_CODENAME' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
            REV=$(grep '^DISTRIB_RELEASE' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
        fi
        if [ -f /etc/UnitedLinux-release ] ; then
            DIST="${DIST}[$(cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//)]"
        fi
        declare -r OS
        declare -r KERNEL
        declare -r MACH
        declare -r DIST
        declare -r DIST_BASE
        declare -r REV_NAME
        declare -r REV
    fi
fi
system_info() {
  local dist_base
  local rev
  [ -n "$DIST_BASE" ] && dist_base=" based on $DIST_BASE"
  [ -n "$REV" ] && rev=" $REV $REV_NAME"
  echo "$OS system with kernel $KERNEL $MACH ($DIST$rev$dist_base)"
}
hw_cores() { grep -c ^processor /proc/cpuinfo; }
hw_processor() { grep 'model name' /proc/cpuinfo | head -n 1 | sed 's/^.*: //'; }
hw_memory_mb() { free -m | grep -oP '\d+' | head -n 1; }
hw_disks() {
    df -lBG | grep ^/dev/ | awk '{print $2, $5, $6}'
}
ip_main() { ip route get 1 | awk '{print $NF;exit}'; }
ip_list() { LANG=C /sbin/ifconfig | grep inet | egrep -v "127.0.0.1|::1/128" | sed 's/: /:/;s/^.*addr:\(.*\)/\1/;s/ .*$//'; }
declare -A _package_debian
_package_debian[apache]="apache2"
_package_debian[tomcat]="tomcat7 tomcat8"
_package_debian[jdk]="openjdk-11-jdk openjdk-10-jdk openjdk-9-jdk openjdk-8-jdk openjdk-7-jdk openjdk-6-jdk"
_package_debian[jre]="openjdk-11-jre openjdk-10-jre openjdk-9-jre openjdk-8-jre openjdk-7-jre openjdk-6-jre"
_package_debian[postgresql]="postgresql-10 postgresql-9.6 postgresql-9.4 postgresql-9.3"
package() {
    [ "$#" -ne 1 ] && log_exit ALERT "parameter missing. Usage: info_package <name>"
    unset IFS
    case $DIST_BASE in
    Debian)
        alt=${_package_debian[$1]}
        if [ -n "$alt" ]; then
            for check in $alt
            do
                local found=$(dpkg -s $check 2>/dev/null)
                if [ -n "$found" ]; then
                    result=$(echo -e "$found" | grep Version | sed "s/Version: //")
                    log DEBUG "package $1 is installed with version $result"
                    echo $result
                return 0
                fi
            done
        else
            local found=$(dpkg -s $1 2>/dev/null)
            [ $? -eq 0 ] || return 1
            result=$(echo -e "$found" | grep Version | sed "s/Version: //")
            log DEBUG "package $1 is installed with version $result"
            echo $result
            return 0
        fi
        return 1
        ;;
    *)
        log_exit ALERT "operating system not supported: $(system_info)"
        ;;
    esac
}
