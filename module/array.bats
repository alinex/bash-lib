#!/usr/bin/env bats

# bats file_tags=array
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# contains
######################################################################################

# bats test_tags=contains
@test "contains: should find entry" {
    x=( one two three )
    run contains x two
    assert_success
}
# bats test_tags=contains
@test "contains: should not find entry" {
    # shellcheck disable=SC2034
    x=( one two three )
    run contains x ten
    assert_failure
}
