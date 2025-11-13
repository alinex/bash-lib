#!/usr/bin/env bats

# bats file_tags=file
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
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
# dirname
######################################################################################

# bats test_tags=dirname
@test "dirname: should get path" {
    run dirname /my/file
    assert_output "/my"
    assert_success
}
# bats test_tags=dirname
@test "dirname: pipe path" {
    run bats_pipe echo /my/file \| dirname
    assert_output "/my"
    assert_success
}

######################################################################################
# extname
######################################################################################

# bats test_tags=extname
@test "extname: should get path" {
    run extname /my/file.config
    assert_output ".config"
    assert_success
}
# bats test_tags=extname
@test "extname: pipe path" {
    run bats_pipe echo /my/file.config \| extname
    assert_output ".config"
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
