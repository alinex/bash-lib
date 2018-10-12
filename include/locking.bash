#!/bin/bash

# Library to serialize parallel tasks
#
# https://gitlab.ekz.de/divibib-betrieb/bash-lib/blob/master/doc/locking.md
#
# Usage:
#
# source ../bash-lib/include/locking.bash  # load functions
# lockfile=<file mostly in tmp folder>
# lock $lockfile   # create the lock
# exit_lock $lockfile   # ... and exit if already locked
# unlock $lockfile # remove the lock
#
# The second process which want to set the lock will wait till the lock is released.

source_dir=$(dirname "${BASH_SOURCE[0]}")
source "$source_dir/errors.bash" # load error handler

# set a lock or wait till it can be set
# parameter:
# - lockfile path
lock() {
    [ "$#" -ne 1 ] && log_exit ALERT "incorrect library call use: lock <lockfile>"

    local lockfile="$1"

    # make a file with our PID
    echo $$ > "$lockfile.$$" 2>/dev/null || log_exit ALERT "failed to create PID lockfile: $lockfile.$$"

    # remove old locks for non existing processes
    if [ -e "$lockfile" ] ; then
        pid=$(cat $lockfile || log_exit ALERT "could not read lockfile $lockfile")
        kill -0 $pid 2>/dev/null || rm -f "$lockfile" || log_exit ALERT "failed to remove lockfile: $lockfile"
    fi

    # try to symlink it
    while ! ln "$lockfile.$$" "$lockfile" 2>/dev/null
    do
        # if the symlink failed, wait for the current lock holder to exit
        sleep 1
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
exit_lock() {
    [ "$#" -lt 1 ] && log_exit ALERT "incorrect library call use: exit_lock <lockfile> [<error message>] [<exit code>]"

    local lockfile="$1"
    local default="Stop processing because this is locked in $lockfile by $pid"
    local message="${2:-$default}"
    local exit_code="$3"

    # check for existing lock
    if [ -e "$lockfile" ] ; then
        pid=$(cat $lockfile || log_exit ALERT "could not read lockfile $lockfile" $exit_code)
        log_exit NOTICE $message
    fi

    lock $lockfile
    return $?
}

# remove the lock
# parameter:
# - lockfile path
unlock() {
    [ "$#" -ne 1 ] && log_exit ALERT "incorrect library call use: unlock <lockfile>"

    local lockfile="$1"

    # remove the trap
    trap - EXIT

    # remove the lock files
    rm -f "$lockfile.$$" || log_exit ALERT "failed to remove PID lockfile: $lockfile.$$"
    if [ -e "$lockfile" ] ; then
        pid=$(cat $lockfile || log_exit ALERT "could not read lockfile $lockfile")
        if [ "$pid" -eq "$$" ]; then
            rm -f "$lockfile" || log_exit ALERT "failed to remove lockfile: $lockfile"
        else
            log_exit ALERT "could not remove lockfile because it is set from another process"
        fi
    fi

    return 0
}
