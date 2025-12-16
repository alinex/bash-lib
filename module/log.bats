#!/usr/bin/env bats

# bats file_tags=log
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    export testLog=/tmp/testLog
    # declare global used variables
}

######################################################################################
# logging
######################################################################################

# bats test_tags=log
@test "log: don't write debug message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log debug Test
    assert [ ! -e "$testLog" ]
}
# bats test_tags=log
@test "log: write debug message" {
    rm -rf "$testLog"*
    log start "$testLog" --level=debug
    log debug Test
    run cat "$testLog"
    assert_output -p "DEBUG Test"
}
# bats test_tags=log
@test "log: write info message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log info Test
    run cat "$testLog"
    assert_output -p "INFO Test"
}
# bats test_tags=log
@test "log: write notice message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log notice Test
    run cat "$testLog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: write warn message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log warn Test
    run cat "$testLog"
    assert_output -p "WARN Test"
}
# bats test_tags=log
@test "log: write error message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log error Test
    run cat "$testLog"
    assert_output -p "ERROR Test"
}
# bats test_tags=log
@test "log: write critical message" {
    rm -rf "$testLog"*
    log start "$testLog"
    log critical Test
    run cat "$testLog"
    assert_output -p "CRITICAL Test"
}

# bats test_tags=log
@test "log: multiple appenders" {
    rm -rf "$testLog"*
    log start "$testLog"-info
    log start "$testLog"-error
    log error Test
    run cat "$testLog"-info
    assert_output -p "ERROR Test"
    run cat "$testLog"-error
    assert_output -p "ERROR Test"
}
@test "log: stop" {
    rm -rf "$testLog"*
    log start "$testLog"
    log error Test1
    log stop "$testLog"
    log error Test2
    run tail -1 "$testLog"
    assert_output -p "ERROR Test1"
}

# bats test_tags=log
@test "log: with info message" {
    rm -rf "$testLog"*
    log start "$testLog"
    info Test
    run cat "$testLog"
    assert_output -p "INFO Test"
}
# bats test_tags=log
@test "log: with notice message" {
    rm -rf "$testLog"*
    log start "$testLog"
    notice Test
    run cat "$testLog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: with ok message" {
    rm -rf "$testLog"*
    log start "$testLog"
    ok Test
    run cat "$testLog"
    assert_output -p "NOTICE Test"
}
# bats test_tags=log
@test "log: with warn message" {
    rm -rf "$testLog"*
    log start "$testLog"
    warn Test
    run cat "$testLog"
    assert_output -p "WARN Test"
}
# bats test_tags=log
@test "log: with error message" {
    rm -rf "$testLog"*
    log start "$testLog"
    error Test
    run cat "$testLog"
    assert_output -p "ERROR Test"
}
# bats test_tags=log
@test "log: with critical message" {
    rm -rf "$testLog"*
    log start "$testLog"
    critical Test
    run cat "$testLog"
    assert_output -p "CRITICAL Test"
}
# bats test_tags=log
@test "log: with debug message" {
    rm -rf "$testLog"*
    log start "$testLog" --level=debug
    export DEBUG=1
    debug Test
    run cat "$testLog"
    assert_output -p "Test"
}
