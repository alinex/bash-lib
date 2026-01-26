#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=misc
setup() {
    load "$BASHLIB_HOME/tests/bats-library-loader"
}
teardown_file() {
    rm -rf /tmp/bats-exec*
    rm -rf /dev/shm/bats-exec*
}

######################################################################################
# script_path
######################################################################################

# bats test_tags=script_path
@test "script_path: should get directory" {
    run script_path
    # cspell:disable-next-line
    assert_output -p "libexec/bats-core"
    assert_success
}

######################################################################################
# mktemp
######################################################################################

# bats test_tags=mktemp
@test "mktemp: for file" {
    run mktemp
    assert_success
    assert [ -e "$output" ]
}
# bats test_tags=mktemp
@test "mktemp: for directory" {
    run mktemp -d dir
    assert_success
    assert [ -d "$output" ]
}
# bats test_tags=mktemp
@test "mktemp: in memory" {
    run mktemp -m test
    assert_success
    assert [ -e "$output" ]
    assert_output "/dev/shm/bats-exec-test_test"
}
# bats test_tags=mktemp
@test "mktemp: with identifier" {
    run mktemp test
    assert_success
    assert [ -e "$output" ]
    assert_output "/tmp/bats-exec-test_test"
}

######################################################################################
# first
######################################################################################

# bats test_tags=first
@test "first: find element" {
    run first "" "" one two
    assert_success
    assert_output one
}
