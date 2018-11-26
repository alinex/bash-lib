#!/bin/bash

# General helper
#
# http://172.17.101.90/ivibib-betrieb/helper-lib/blob/master/doc/core.md

# get the path from the called command
path() {
    dirname $(readlink -f "${BASH_SOURCE[-1]:-$(pwd)/x}")
}
