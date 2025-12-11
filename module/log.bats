#!/usr/bin/env bats

# bats file_tags=log
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    export testlog=/tmp/testlog
    # declare global used variables
}

######################################################################################
# logging
######################################################################################

# bats test_tags=log
@test "log: don't write debug message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log debug Test
    assert [ ! -e "$testlog" ]
}
# bats test_tags=log
@test "log: write debug message" {
    rm -rf "$testlog"*
    log start "$testlog" --level=debug
    log debug Test
    run cat "$testlog"
    assert_output -p "DEBUG Test"
}
# bats test_tags=log
@test "log: write info message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log info Test
    run cat "$testlog"
    assert_output -p "INFO Test"
}
# bats test_tags=log
@test "log: write notice message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log notice Test
    run cat "$testlog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: write warn message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log warn Test
    run cat "$testlog"
    assert_output -p "WARN Test"
}
# bats test_tags=log
@test "log: write error message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log error Test
    run cat "$testlog"
    assert_output -p "ERROR Test"
}
# bats test_tags=log
@test "log: write critical message" {
    rm -rf "$testlog"*
    log start "$testlog"
    log critical Test
    run cat "$testlog"
    assert_output -p "CRITICAL Test"
}

# bats test_tags=log
@test "log: multiple appenders" {
    rm -rf "$testlog"*
    log start "$testlog"-info
    log start "$testlog"-error
    log error Test
    run cat "$testlog"-info
    assert_output -p "ERROR Test"
    run cat "$testlog"-error
    assert_output -p "ERROR Test"
}
@test "log: stop" {
    rm -rf "$testlog"*
    log start "$testlog"
    log error Test1
    log stop "$testlog"
    log error Test2
    run tail -1 "$testlog"
    assert_output -p "ERROR Test1"
}

# bats test_tags=log
@test "log: with info message" {
    rm -rf "$testlog"*
    log start "$testlog"
    info Test
    run cat "$testlog"
    assert_output -p "INFO Test"
}
# bats test_tags=log
@test "log: with notice message" {
    rm -rf "$testlog"*
    log start "$testlog"
    notice Test
    run cat "$testlog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: with ok message" {
    rm -rf "$testlog"*
    log start "$testlog"
    ok Test
    run cat "$testlog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: with warn message" {
    rm -rf "$testlog"*
    log start "$testlog"
    warn Test
    run cat "$testlog"
    assert_output -p "WARN Test"
}
# bats test_tags=log
@test "log: with error message" {
    rm -rf "$testlog"*
    log start "$testlog"
    error Test
    run cat "$testlog"
    assert_output -p "ERROR Test"
}
# bats test_tags=log
@test "log: with critical message" {
    rm -rf "$testlog"*
    log start "$testlog"
    critical Test
    run cat "$testlog"
    assert_output -p "CRITICAL Test"
}
# bats test_tags=log
@test "log: with debug message" {
    rm -rf "$testlog"*
    log start "$testlog" --level=debug
    export DEBUG=1
    debug Test
    run cat "$testlog"
    assert_output -p "Test"
}
