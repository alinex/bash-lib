#!/usr/bin/env bats

# bats file_tags=monitoring
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

