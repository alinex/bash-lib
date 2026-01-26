#!/usr/bin/env bats

# bats file_tags=crypto
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# Password generator
######################################################################################

# bats test_tags=pw_generator
@test "pw_generator: with default tool" {
    run pw_generator
    assert_success
}
