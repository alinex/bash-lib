#!/usr/bin/env bats

# bats file_tags=ansi
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# COLORS
######################################################################################

# bats test_tags=COLORS
@test "COLORS: should be defined" {
    # shellcheck disable=SC2154
    assert [ "$COLORS" -ge 0 ]
}

######################################################################################
# color_table
######################################################################################

# bats test_tags=color_table
@test "color_table: should succeed" {
    run color_table
    assert_success
}

######################################################################################
# color_256
######################################################################################

# bats test_tags=color_256
@test "color_256: should return color codes" {
    run color_256 40
    assert [ "$output" = $'\033[38;5;40m' ]
    assert_success
}

######################################################################################
# color_256_bg
######################################################################################

# bats test_tags=color_256_bg
@test "color_256_bg: should return color codes" {
    run color_256_bg 40
    assert [ "$output" = $'\033[48;5;40m' ]
    assert_success
}
