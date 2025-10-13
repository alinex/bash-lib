#!/usr/bin/env bats

# bats file_tags=validator
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load .loader
}

# bats test_tags=num_parameters
@test "num_parameters: should work if correct number" {
    run num_parameters p1 p2 --min 1
    assert_output ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=num_parameters
@test "num_parameters: should fail if to few parameters" {
    run num_parameters p1 p2 --min 4
    assert_output -p "Check num_parameters: [p1 p2] 2 < 4"
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=num_parameters
@test "num_parameters: should die on error" {
    run num_parameters p1 p2 --min 4 --die "Wrong call"
    assert_output -p "Wrong call"
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=is_success
@test "is_success: 0 should be ok" {
    run is_success 0
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_success
@test "is_success: 1 should be error" {
    run is_success 1
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=is_empty
@test "is_empty: should work without argument" {
    run is_empty
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_empty
@test "is_empty: should work with empty string" {
    run is_empty ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_empty
@test "is_empty: should fail with somethin in it" {
    run is_empty 123
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=is_integer
@test "is_integer: should work with 234" {
    run is_integer 234
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_integer
@test "is_integer: should fail with 5m" {
    run is_integer 5m
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_integer
@test "is_integer: should work with -234" {
    run is_integer -234
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=is_float
@test "is_float: should work with 234.8" {
    run is_float 234.8
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_float
@test "is_float: should fail with 5m" {
    run is_float 5m
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=is_float
@test "is_float: should work with -234" {
    run is_float -234
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=compare
@test "compare: should work with =" {
    run compare a = a
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with =" {
    run compare a = b
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with ==" {
    run compare a == a
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with ==" {
    run compare a == b
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with !=" {
    run compare a != b
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with !=" {
    run compare a != a
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with =~" {
    run compare axel =~ el\$
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with =~" {
    run compare axel =~ ax\$
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with !~" {
    run compare axel !~ ax\$
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with !~" {
    run compare axel !~ el\$
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with -gt" {
    run compare 5 -gt 1
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with -gt" {
    run compare 1 -gt 5
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should work with >" {
    run compare 5 \> 1
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=compare
@test "compare: should fail with >" {
    run compare 1 \> 5
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=trim_start
@test "trim_start: should remove leading spaces" {
    run trim_start "     xx"
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=trim_start
@test "trim_start: should remove also newline tabs and carriage return" {
    run trim_start $' \r\n\t xx'
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=trim_start
@test "trim_start: should remove other characters" {
    run trim_start ".......xx" "."
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=trim_end
@test "trim_end: should remove trailing spaces" {
    run trim_end "xx     "
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=trim_end
@test "trim_end: should remove also newline tabs and carriage return" {
    run trim_end $'xx \r\n\t '
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=trim
@test "trim: should remove spaces" {
    run trim "     xx     "
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=trim
@test "trim: should remove also newline tabs and carriage return" {
    run trim $' \r\n\t xx \r\n\t '
    assert_output "xx"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
