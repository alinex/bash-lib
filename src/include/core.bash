#!/bin/bash

# General helper
#
# https://gitlab.com/alinex/bash-lib/blob/master/doc/log.md

# get the path from the called command
#
path() {
    dirname $(readlink -f "${BASH_SOURCE[-1]:-$(pwd)/x}")
}

# check if sudo can be used and should be used
# Output: 'sudo' or ''
usesudo() {
    [ $(id -u) -ne 0 ] && sudo -v 2>/dev/null && cmd="sudo" || cmd=""
    echo $cmd
}

# Usage: needsudo [<commandline>]...
# Exit on problem
needsudo() {
    [ $(id -u) -eq 0 ] && return 0
    sudo -v 2>/dev/null || log_exit ALERT "For this call root rights are needed! Please use another user or allow sudo for user $(whoami)."
    for cmd in "$@"; do
        sudo -l $cmd || log_exit ALERT "User $(whoami) is not allowed to call 'sudo $cmd', but this is neccessary!"
    done
}
