#!/usr/bin/env bats

# bats file_tags=array
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# array
######################################################################################

# bats test_tags=array
@test "array: has value" {
    declare -g test_array
    # shellcheck disable=SC2190
    test_array=(one two three)
    run array test_array has two
    assert_success
}
# bats test_tags=array
@test "array: not has value" {
    declare -g test_array
    # shellcheck disable=SC2190
    test_array=(one two three)
    run array test_array has nine
    assert_failure
}
# bats test_tags=array2
@test "array: indexof value" {
    declare -g test_array
    # shellcheck disable=SC2190
    test_array=(one two three)
    run array test_array indexof two
    assert_output "1"
    assert_success
}

######################################################################################
# join
######################################################################################

# bats test_tags=join
@test "join: use default separator" {
    x=( one two three )
    run join x
    assert_output "one,two,three"
    assert_success
}
# bats test_tags=join
@test "join: use custom separator" {
    x=( one two three )
    run join x ", "
    assert_output "one, two, three"
    assert_success
}

######################################################################################
# split
######################################################################################

# bats test_tags=split
@test "split: use default separator" {
    x=()
    split "one,two,three" x
    assert [ "${x[*]}" = "one two three" ]
}
# bats test_tags=split
@test "split: use custom separator" {
    x=()
    split "one, two, three" x ", "
    assert [ "${x[*]}" = "one two three" ]
}

######################################################################################
# hash
######################################################################################

# bats test_tags=hash
@test "hash: set value" {
    declare -Ag test_array
    run hash test_array set one 1
    assert_success
}
# bats test_tags=hash
@test "hash: get value" {
    declare -Ag test_array
    test_array["one"]=1
    run hash test_array get one
    assert_output "1"
    assert_success
}
# bats test_tags=hash
@test "hash: get value (base64)" {
    declare -Ag test_array
    test_array["b25lCg=="]=1
    run hash --key-format=base64 test_array get one
    assert_output "1"
    assert_success
}
# bats test_tags=hash
@test "hash: has value" {
    declare -Ag test_array
    test_array["one"]=1
    run hash test_array has one
    assert_success
}
# bats test_tags=hash
@test "hash: has no value" {
    declare -Ag test_array
    test_array["one"]=1
    run hash test_array has ninetyNine
    assert_failure
}
# bats test_tags=hash
@test "hash: unset value" {
    declare -Ag test_array
    test_array["one"]=1
    hash test_array unset one
    run hash test_array has one   
    assert_failure
}
# bats test_tags=hash
@test "hash: complex key" {
    declare -Ag test_array
    # shellcheck disable=SC2034
    test_array["o_n_e"]=1
    run hash test_array has "o n%e"   
    assert_success
}
