#!/bin/bash

# General helper
#
# https://gitlab.com/alinex/bash-lib/blob/master/doc/log.md

# get the path from the called command
path() {
    dirname $(readlink -f "${BASH_SOURCE[-1]:-$(pwd)/x}")
}
