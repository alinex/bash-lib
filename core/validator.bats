#!/usr/bin/env bats

# bats file_tags=validator
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
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
@test "is: should die for set" {
    run is set "" --die
    assert_failure
    assert_output -p '"argument" muss mit einem Wert gesetzt werden'
}
# bats test_tags=is
@test "is: should die for set (named argument)" {
    run is set "" --name=age --die
    assert_failure
    assert_output -p '"age" muss mit einem Wert gesetzt werden'
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
@test "is: should check for integer (negative)" {
    run is integer --output -- -5
    assert_success
    assert_output "-5"
}
# bats test_tags=is
@test "is: should fail for integer" {
    run is integer five
    assert_failure
}
# bats test_tags=is
@test "is: should check for integer with sanitize" {
    run is integer --sanitize --output -- 5.27k
    assert_success
    assert_output "5"
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

# bats test_tags=is
@test "is: should check for duration (number)" {
    run is duration --output -- 600
    assert_success
    assert_output "600"
}
# bats test_tags=is
@test "is: should check for duration (human)" {
    run is duration --output -- 1h30m
    assert_success
    assert_output "5400"
}
# bats test_tags=is
@test "is: should fail for duration" {
    run is duration init
    assert_failure
}

######################################################################################
# check
######################################################################################

# bats test_tags=check
@test "check: string = value (true)" {
    run check string aaa = aaa
    assert_success
}
# bats test_tags=check
@test "check: string = value (false)" {
    run check string aaa = bbb
    assert_failure
}

# bats test_tags=check
@test "check: string == value (true)" {
    run check string aaa == aaa
    assert_success
}
# bats test_tags=check
@test "check: string == value (false)" {
    run check string aaa == bbb
    assert_failure
}

# bats test_tags=check
@test "check: string != value (true)" {
    run check string aaa != bbb
    assert_success
}
# bats test_tags=check
@test "check: string != value (false)" {
    run check string aaa != aaa
    assert_failure
}

# bats test_tags=check
@test "check: string =* value (true)" {
    run check string aaa =\* a\*
    assert_success
}
# bats test_tags=check
@test "check: string =* value (false)" {
    run check string aaa =\* b\*
    assert_failure
}

# bats test_tags=check
@test "check: string !* value (true)" {
    run check string aaa !\* b\*
    assert_success
}
# bats test_tags=check
@test "check: string !* value (false)" {
    run check string aaa !\* a\*
    assert_failure
}

# bats test_tags=check
@test "check: string =~ value (true)" {
    run check string aaa =~ 'a.*'
    assert_success
}
# bats test_tags=check
@test "check: string =~ value (false)" {
    run check string aaa =~ 'b.*'
    assert_failure
}

# bats test_tags=check
@test "check: string !~ value (true)" {
    run check string aaa \!~ 'b.*'
    assert_success
}
# bats test_tags=check
@test "check: string !~ value (false)" {
    run check string aaa \!~ 'a.*'
    assert_failure
}

# bats test_tags=check
@test "check: string < value (true)" {
    run check string a \< b
    assert_success
}
# bats test_tags=check
@test "check: string < value (false)" {
    run check string c \< b
    assert_failure
}

# bats test_tags=check
@test "check: string > value (true)" {
    run check string c \> b
    assert_success
}
# bats test_tags=check
@test "check: string > value (false)" {
    run check string a \> b
    assert_failure
}

# bats test_tags=check
@test "check: string empty (true)" {
    run check string "" empty
    assert_success
}
# bats test_tags=check
@test "check: string empty (false)" {
    run check string c empty
    assert_failure
}

# bats test_tags=check
@test "check: string set (true)" {
    run check string a set
    assert_success
}
# bats test_tags=check
@test "check: string set (false)" {
    run check string "" set
    assert_failure
}

# bats test_tags=check
@test "check: integer = value (true)" {
    run check integer 1 = 1
    assert_success
}
# bats test_tags=check
@test "check: integer = value (false)" {
    run check integer 1 = 2
    assert_failure
}

# bats test_tags=check
@test "check: integer < value (true)" {
    run check integer 1 \< 2
    assert_success
}
# bats test_tags=check
@test "check: integer < value (false)" {
    run check integer 3 \< 2
    assert_failure
}

# bats test_tags=check
@test "check: integer > value (true)" {
    run check integer 3 \> 2
    assert_success
}
# bats test_tags=check
@test "check: integer > value (false)" {
    run check integer 1 \> 2
    assert_failure
}

# bats test_tags=check
@test "check: integer <= value (true)" {
    run check integer 1 \<= 2
    assert_success
}
# bats test_tags=check
@test "check: integer <= value (false)" {
    run check integer 3 \<= 2
    assert_failure
}

# bats test_tags=check
@test "check: integer >= value (true)" {
    run check integer 3 \>= 2
    assert_success
}
# bats test_tags=check
@test "check: integer >= value (false)" {
    run check integer 1 \>= 2
    assert_failure
}

# bats test_tags=check
@test "check: integer positiv (true)" {
    run check integer 3 positiv
    assert_success
}
# bats test_tags=check
@test "check: integer positiv (false)" {
    run check integer -1 positiv
    assert_failure
}

# bats test_tags=check
@test "check: integer negativ (true)" {
    run check integer -3 negativ
    assert_success
}
# bats test_tags=check
@test "check: integer negativ (false)" {
    run check integer 1 negativ
    assert_failure
}

# bats test_tags=check
@test "check: integer zero (true)" {
    run check integer 0 zero
    assert_success
}
# bats test_tags=check
@test "check: integer zero (false)" {
    run check integer 1 zero
    assert_failure
}

# bats test_tags=check
@test "check: integer odd (true)" {
    run check integer 1 odd
    assert_success
}
# bats test_tags=check
@test "check: integer odd (false)" {
    run check integer 2 odd
    assert_failure
}

# bats test_tags=check
@test "check: integer even (true)" {
    run check integer 0 even
    assert_success
}
# bats test_tags=check
@test "check: integer even (false)" {
    run check integer 1 even
    assert_failure
}

# bats test_tags=check
@test "check: integer multiple-of (true)" {
    run check integer 6 multiple-of 2
    assert_success
}
# bats test_tags=check
@test "check: integer multiple-of (false)" {
    run check integer 1 multiple-of 2
    assert_failure
}

# bats test_tags=check
@test "check: integer divisible-by (true)" {
    run check integer 6 divisible-by 2
    assert_success
}
# bats test_tags=check
@test "check: integer divisible-by (false)" {
    run check integer 1 divisible-by 2
    assert_failure
}

# bats test_tags=check
@test "check: integer factor-of (true)" {
    run check integer 2 factor-of 6
    assert_success
}
# bats test_tags=check
@test "check: integer factor-of (false)" {
    run check integer 3 factor-of 5
    assert_failure
}

# bats test_tags=check
@test "check: integer prime (true)" {
    run check integer 11 prime
    assert_success
}
# bats test_tags=check
@test "check: integer prime (false)" {
    run check integer 12 prime
    assert_failure
}

# bats test_tags=check
@test "check: integer no-prime (true)" {
    run check integer 12 no-prime
    assert_success
}
# bats test_tags=check
@test "check: integer no-prime (false)" {
    run check integer 11 no-prime
    assert_failure
}

# bats test_tags=check
@test "check: float = value (true)" {
    run check float 1.3 = 1.3
    assert_success
}
# bats test_tags=check
@test "check: float = value (false)" {
    run check float 1.4 = 1.3
    assert_failure
}

# bats test_tags=check
@test "check: float < value (true)" {
    run check float 1.2 \< 2.4
    assert_success
}
# bats test_tags=check
@test "check: float < value (false)" {
    run check float 3.5 \< 2.4
    assert_failure
}

# bats test_tags=check
@test "check: float > value (true)" {
    run check float 3.5 \> 2.4
    assert_success
}
# bats test_tags=check
@test "check: float > value (false)" {
    run check float 1.5 \> 2.4
    assert_failure
}

# bats test_tags=check
@test "check: float <= value (true)" {
    run check float 1.5 \<= 2.4
    assert_success
}
# bats test_tags=check
@test "check: float <= value (false)" {
    run check float 3.5 \<= 2.4
    assert_failure
}

# bats test_tags=check
@test "check: float >= value (true)" {
    run check float 3.5 \>= 2.4
    assert_success
}
# bats test_tags=check
@test "check: float >= value (false)" {
    run check float 1.5 \>= 2.4
    assert_failure
}

# bats test_tags=check
@test "check: float positiv (true)" {
    run check float 3.5 positiv
    assert_success
}
# bats test_tags=check
@test "check: float positiv (false)" {
    run check float -1.5 positiv
    assert_failure
}

# bats test_tags=check
@test "check: float negativ (true)" {
    run check float -3.5 negativ
    assert_success
}
# bats test_tags=check
@test "check: float negativ (false)" {
    run check float 1.5 negativ
    assert_failure
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
