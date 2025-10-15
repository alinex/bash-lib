#!/usr/bin/env bats

# bats file_tags=atlassian
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

# bats test_tags=confluence
@test "confluence: should find entry" {
    run confluence 677347344
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
