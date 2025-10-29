#!/usr/bin/env bats

# bats file_tags=file
setup() {
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
    load $BASHLIB_HOME/loader
}

# bats test_tags=script_path
@test "script_path: should get directory" {
    run script_path
    assert_output "/usr/libexec/bats-core"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
