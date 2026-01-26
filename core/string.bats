#!/usr/bin/env bats

# bats file_tags=string
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# trim_start
######################################################################################

# bats test_tags=trim_start
@test "trim_start: should remove leading spaces" {
    run trim_start "     xx"
    assert_output "xx"
    assert_success
}
# bats test_tags=trim_start
@test "trim_start: should remove also newline tabs and carriage return" {
    run trim_start $' \r\n\t xx'
    assert_output "xx"
    assert_success
}
# bats test_tags=trim_start
@test "trim_start: should remove other characters" {
    run trim_start ".......xx" "."
    assert_output "xx"
    assert_success
}

######################################################################################
# trim_end
######################################################################################

# bats test_tags=trim_end
@test "trim_end: should remove trailing spaces" {
    run trim_end "xx     "
    assert_output "xx"
    assert_success
}
# bats test_tags=trim_end
@test "trim_end: should remove also newline tabs and carriage return" {
    run trim_end $'xx \r\n\t '
    assert_output "xx"
    assert_success
}

######################################################################################
# trim
######################################################################################

# bats test_tags=trim
@test "trim: should remove spaces" {
    run trim "     xx     "
    assert_output "xx"
    assert_success
}
# bats test_tags=trim
@test "trim: should remove also newline tabs and carriage return" {
    run trim $' \r\n\t xx \r\n\t '
    assert_output "xx"
    assert_success
}

######################################################################################
# to_alphanum
######################################################################################

# bats test_tags=to_alphanum
@test "to_alphanum: should replace other characters" {
    run to_alphanum $'This is a\n text+1'
    assert_output "This_is_a__text_1"
    assert_success
}
