#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=internal
setup() {
    load "$BASHLIB_HOME"/tests/bats-support/load.bash
    load "$BASHLIB_HOME"/tests/bats-assert/load.bash
    load "$BASHLIB_HOME"/loader
}

######################################################################################
# _deprecated
######################################################################################

# bats test_tags=_deprecated
@test "_deprecated: with message" {
    DEBUG="" run _deprecated "no longer used"
    assert_output  --regexp "DEPRECATED: bats_merge_stdout_and_stderr at run in .* no longer used"
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}

######################################################################################
# _stacktrace
######################################################################################

# bats test_tags=_stacktrace
@test "_stacktrace: show" {
    DEBUG="" run _stacktrace
    assert_output ""
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
