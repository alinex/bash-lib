#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=os
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# detect_os
######################################################################################

# bats test_tags=detect_os
@test "detect_os: OS should be defined" {
    detect_os
    assert_success
    assert [ -n "$OS" ]
}
# bats test_tags=detect_os
@test "detect_os: KERNEL should be defined" {
    detect_os
    assert_success
    assert [ -n "$KERNEL" ]
}
# bats test_tags=detect_os
@test "detect_os: MACH should be defined" {
    detect_os
    assert_success
    assert [ -n "$MACH" ]
}
# bats test_tags=detect_os
@test "detect_os: MACH_ID should be defined" {
    detect_os
    assert_success
    assert [ -n "$MACH_ID" ]
}

######################################################################################
# system_info
######################################################################################

# bats test_tags=system_info
@test "system_info: should get timestamp" {
    run system_info
    assert_success
}

######################################################################################
# has_tty
######################################################################################

# bats test_tags=has_tty
@test "has_tty: should get timestamp" {
    run has_tty
    assert_success
}

######################################################################################
# is_bash
######################################################################################

# bats test_tags=is_bash
@test "is_bash: should get timestamp" {
    run is_bash
    assert_success
}
