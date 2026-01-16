#!/usr/bin/env bats

# bats file_tags=git
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# basename
######################################################################################

# bats test_tags=git_info
@test "git_info: should get url" {
    run git_info url
    assert_output "https://gitlab.com/alinex/bash-lib"
    assert_success
}
# bats test_tags=git_info
@test "git_info: should get tag" {
    run git_info tag
    assert_success
}
