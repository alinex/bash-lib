#!/usr/bin/env bats

# bats file_tags=validator
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# check
######################################################################################

# bats test_tags=check
@test "check: should check for set" {
    run check set "x"
    assert_success
    assert_output "x"
}
# bats test_tags=check
@test "check: should fail for set" {
    run check set ""
    assert_failure
}
# bats test_tags=check
@test "check: should die for set" {
    run check set "" --die
    assert_failure
    assert_output -p '"argument" muss mit einem Wert gesetzt werden'
}
# bats test_tags=check
@test "check: should die for set (named argument)" {
    run check set "" --name=age --die
    assert_failure
    assert_output -p '"age" muss mit einem Wert gesetzt werden'
}

# bats test_tags=check
@test "check: should check for empty" {
    run check empty ""
    assert_success
    assert_output ""
}
# bats test_tags=check
@test "check: should fail for empty" {
    run check empty "x"
    assert_failure
}

# bats test_tags=check
@test "check: should check for bool true" {
    run check bool "true"
    assert_success
    assert_output "1"
}
# bats test_tags=check
@test "check: should check for bool false" {
    run check bool "F"
    assert_success
    assert_output "0"
}
# bats test_tags=check
@test "check: should fail for bool" {
    run check bool "?"
    assert_failure
}

# bats test_tags=check
@test "check: should check for integer" {
    run check integer 5
    assert_success
    assert_output "5"
}
# bats test_tags=check
@test "check: should check for integer (negative)" {
    run check integer -- -5
    assert_success
    assert_output "-5"
}
# bats test_tags=check
@test "check: should fail for integer" {
    run check integer five
    assert_failure
}
# bats test_tags=check
@test "check: should check for integer with sanitize" {
    run check integer 5.27k --sanitize
    assert_success
    assert_output "5"
}
# bats test_tags=check
@test "check: should check for integer with min" {
    run check integer 6 --min=5
    assert_success
    assert_output "6"
}
# bats test_tags=check
@test "check: should fail for integer with min" {
    run check integer 3 --min=5
    assert_failure
}
# bats test_tags=check
@test "check: should check for integer with max" {
    run check integer 3 --max=5
    assert_success
    assert_output "3"
}
# bats test_tags=check
@test "check: should fail for integer with max" {
    run check integer 6 --max=5
    assert_failure
}

# bats test_tags=check
@test "check: should check for float" {
    run check float 5.8
    assert_success
    assert_output "5.8"
}

# bats test_tags=check
@test "check: should check for enum" {
    run check enum test --allow="check test run doc"
    assert_success
    assert_output "test"
}
# bats test_tags=check
@test "check: should fail for enum" {
    run check enum init --allow="check test run doc"
    assert_failure
}

######################################################################################
# is
######################################################################################

# bats test_tags=is
@test "is: should check for set" {
    run is set "x"
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for set" {
    run is set ""
    assert_failure
}

# bats test_tags=is
@test "is: should check for empty" {
    run is empty ""
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for empty" {
    run is empty "x"
    assert_failure
}

# bats test_tags=is
@test "is: should check for bool true" {
    run is bool "true"
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should check for bool false" {
    run is bool "F"
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for bool" {
    run is bool "?"
    assert_failure
}

# bats test_tags=is
@test "is: should check for integer" {
    run is integer 5
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for integer" {
    run is integer five
    assert_failure
}
# bats test_tags=is
@test "is: should check for integer with min" {
    run is integer 6 --min=5
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for integer with min" {
    run is integer 3 --min=5
    assert_failure
}
# bats test_tags=is
@test "is: should check for integer with max" {
    run is integer 3 --max=5
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for integer with max" {
    run is integer 6 --max=5
    assert_failure
}

# bats test_tags=is
@test "is: should check for float" {
    run is float 5.8
    assert_success
    assert_output ""
}

# bats test_tags=is
@test "is: should check for enum" {
    run is enum test --allow="check test run doc"
    assert_success
    assert_output ""
}
# bats test_tags=is
@test "is: should fail for enum" {
    run is enum init --allow="check test run doc"
    assert_failure
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

######################################################################################
# value_if_variable
######################################################################################

# bats test_tags=value_if_variable
@test "value_if_variable: use value if no variable" {
    run value_if_variable "no_var"
    assert_output "no_var"
    assert_success
}
# bats test_tags=value_if_variable
@test "value_if_variable: invalid variable name" {
    run value_if_variable "this & that"
    assert_output "this & that"
    assert_success
}
# bats test_tags=value_if_variable
@test "value_if_variable: use referenced variable" {
    # shellcheck disable=SC2034
    value=55
    run value_if_variable "value"
    assert_output "55"
    assert_success
}
