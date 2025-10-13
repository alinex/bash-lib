#!/usr/bin/env bats

# bats file_tags=divibib
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load .loader
}

