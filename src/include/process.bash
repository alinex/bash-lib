#!/bin/bash

# Library to serialize parallel tasks
#
# http://172.17.101.90/ivibib-betrieb/bash-lib/blob/master/doc/process.md

source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/log.bash" # load log handler


declare -i LOCK_SLEEP=${LOCK_SLEEP:-10}
declare LOCKFILE="${LOCKFILE:-/tmp/$(basename $0)-lock}"

# remove lockfile if the process isn't running any more
# parameter:
# - lockfile path
_lock_remove() {
    # remove old locks for non existing processes
    if [ -e "$1" ] ; then
        pid=$(cat "$1" || log_exit ALERT "could not read lockfile $1")
        kill -0 "$pid" 2>/dev/null || rm -f "$1" || log_exit ALERT "failed to remove lockfile: $1"
        sleep 3
    fi
}

# set a lock or wait till it can be set
# parameter:
# - lockfile path
lock() {
    local lockfile="${1:-$LOCKFILE}"

    # make a file with our PID
    echo $$ > "$lockfile.$$" 2>/dev/null || log_exit ALERT "failed to create PID lockfile: $lockfile.$$"

    _lock_remove "$lockfile"

    # try to symlink it
    while ! ln "$lockfile.$$" "$lockfile" 2>/dev/null; do
        log INFO "...waiting for lock $lockfile"
        # if the symlink failed, wait for the current lock holder to exit
        sleep $LOCK_SLEEP
    done
    # symlink was created successfully, lock acquired

    # if the locking process exits without unlocking, delete our lock
    #trap 'rm -f "$lockfile" "$lockfile.$$"' EXIT
    trap 'unlock $lockfile' EXIT

    return 0
}

# set the lock or exit with optional error message
# parameter:
# - lockfile path
# - error-message (optional)
# - error-code (optional)
lock_exit() {
    local lockfile="${1:-$LOCKFILE}"
    local default="Stop processing because this is locked in $lockfile by $(cat $lockfile)"
    local message="${2:-$default}"
    local exit_code="$3"

    _lock_remove "$lockfile"

    # check for existing lock
    if [ -e "$lockfile" ] ; then
        pid=$(cat "$lockfile" || log_exit ALERT "could not read lockfile $lockfile" "$exit_code")
        log_exit WARN "$message"
    fi

    lock "$lockfile"
    return $?
}

# remove the lock
# parameter:
# - lockfile path
unlock() {
    local lockfile="${1:-$LOCKFILE}"

    # remove the trap
    trap - EXIT

    # remove the lock files
    rm -f "$lockfile.$$" || log_exit ALERT "failed to remove PID lockfile: $lockfile.$$"
    if [ -e "$lockfile" ] ; then
        pid=$(cat "$lockfile" || log_exit ALERT "could not read lockfile $lockfile")
        if [ "$pid" -eq "$$" ]; then
            rm -f $lockfile* || log_exit ALERT "failed to remove lockfile: $lockfile"
        else
            log_exit ALERT "could not remove lockfile because it is set from another process"
        fi
    fi

    return 0
}

declare -A _async

# parameter:
# - command
# - arguments...
async() {
    [ "$#" -lt 1 ] && log_exit ALERT "parameter missing. Usage: async <command> [<args>...]"
    async_name $1 $@
}

# parameter:
# - identifier
# - command
# - arguments...
async_name() {
    [ "$#" -lt 2 ] && log_exit ALERT "parameter missing. Usage: async <name> <command> [<args>...]"
    local name="$1"
    if [ -n "$STEPFILE" ] && [ -e "$STEPFILE" ] && grep -q "step $name" $STEPFILE; then
        log INFO "Job $name already done in this run, skipping"
        return
    fi
    local call=$(printf "%q " "${@:2}")
    eval "$call" &
    _async[$name]=$! # store pid
}

# parameter:
# - identifier or command
# - method to process failures
async_wait() {
    [ -z "${_async["$1"]}" ] && return
    wait "${_async["$1"]}"
    code=$?
    if [ "$code" -eq 0 ]; then
        [ -n "$STEPFILE" ] \
            && echo "step $1 finished at $(date '+%Y-%m-%d %H:%M:%S')" >>$STEPFILE
    else
        [ -n "$2" ] && $2 "Call to $1 failed with code $code"
    fi
    return $code
}
