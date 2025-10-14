#!/usr/bin/env bats

# bats file_tags=array
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

# bats test_tags=contains
@test "contains: should find entry" {
    x=( one two three )
    run contains x two
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=contains
@test "contains: should not find entry" {
    x=( one two three )
    run contains x ten
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
