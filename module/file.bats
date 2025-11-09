#!/usr/bin/env bats

# bats file_tags=file
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# basename
######################################################################################

# bats test_tags=basename
@test "basename: should get file" {
    run basename /my/file
    assert_output "file"
    assert_success
}
# bats test_tags=basename
@test "basename: should also remove ending slash" {
    run basename /my/file/
    assert_output "file"
    assert_success
}
# bats test_tags=basename
@test "basename: pipe path" {
    run bats_pipe echo /my/file \| basename
    assert_output "file"
    assert_success
}

######################################################################################
# script_path
######################################################################################

# bats test_tags=script_path
@test "script_path: should get directory" {
    run script_path
    assert_output -p "libexec/bats-core"
    assert_success
}
