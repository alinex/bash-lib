#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=os
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    # declare global used variables
    declare -Ag _os_detected
}

######################################################################################
# os_detect
######################################################################################

# bats test_tags=os_detect
@test "os_detect: detect data" {
    run os_detect data
    assert_output -p "os"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect info" {
    run os_detect info
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect base" {
    run os_detect base
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect distribution" {
    run os_detect distribution
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect revision_number" {
    run os_detect revision_number
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect kernel" {
    run os_detect kernel
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect cpu_model" {
    run os_detect cpu_model
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect cpu_num" {
    run os_detect cpu_num
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect architecture" {
    run os_detect architecture
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect machine_id" {
    run os_detect machine_id
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os_detect
@test "os_detect: detect virtual_machine" {
    run os_detect virtual_machine
    assert_output -e ".+"
    assert_success
}

######################################################################################
# disk_free
######################################################################################

# bats test_tags=disk_free
@test "disk_free: should display" {
    run disk_free
    assert_success
}
# bats test_tags=disk_free
@test "disk_free: should dosplay root only" {
    run bats_pipe disk_free / \| wc -l
    assert_output "2"
    assert_success
}
# bats test_tags=disk_free
@test "disk_free: should dosplay root local" {
    run disk_free -l
    assert_success
}
# bats test_tags=disk_free
@test "disk_free: collect free percent" {
    run disk_free --collect=array --free="<99%"
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
