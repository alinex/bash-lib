#!/usr/bin/env bats

# bats file_tags=file
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# script_path
######################################################################################

# bats test_tags=script_path
@test "script_path: should get directory" {
    run script_path
    assert_output -p "libexec/bats-core"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
