#!/usr/bin/env bats

# bats file_tags=color
setup() {
    load "../bats-support/load"
    load "../bats-assert/load"
    load $BASHLIB_HOME/loader
}

# bats test_tags=COLORS
@test "COLORS: should be defined" {
    assert [ "$COLORS" -ge 0 ]
}

# bats test_tags=color_table
@test "color_table: should succeed" {
    run color_table
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=color_256
@test "color_256: should return color codes" {
    run color_256 40
    assert [ "$output" = $'\033[38;5;40m' ]
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=color_256_bg
@test "color_256_bg: should return color codes" {
    run color_256_bg 40
    assert [ "$output" = $'\033[48;5;40m' ]
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
