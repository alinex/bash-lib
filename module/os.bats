#!/usr/bin/env bats

# bats file_tags=os
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load .loader
}

# bats test_tags=OS
@test "OS: should be defined" {
    detect_os
    assert [ -n "$OS" ]
}

# bats test_tags=KERNEL
@test "KERNEL: should be defined" {
    detect_os
    assert [ -n "$KERNEL" ]
}

# bats test_tags=MACH
@test "MACH: should be defined" {
    detect_os
    assert [ -n "$MACH" ]
}

# bats test_tags=MACH_ID
@test "MACH_ID: should be defined" {
    detect_os
    assert [ -n "$MACH_ID" ]
}

# bats test_tags=system_info
@test "system_info: should get timestamp" {
    run system_info
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=has_tty
@test "has_tty: should get timestamp" {
    run has_tty
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=is_bash
@test "is_bash: should get timestamp" {
    run is_bash
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
