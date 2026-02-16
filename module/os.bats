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
# os
######################################################################################

# bats test_tags=os
@test "os: detect data" {
    run os data
    assert_output -p "os"
    assert_success
}
# bats test_tags=os
@test "os: detect info" {
    run os info
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect base" {
    run os base
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect distribution" {
    run os distribution
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect revision_number" {
    run os revision_number
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect kernel" {
    run os kernel
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect cpu_model" {
    run os cpu_model
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect cpu_num" {
    run os cpu_num
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect architecture" {
    run os architecture
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect machine_id" {
    run os machine_id
    assert_output -e ".+"
    assert_success
}
# bats test_tags=os
@test "os: detect virtual_machine" {
    run os virtual_machine
    assert_output -e ".+"
    assert_success
}

######################################################################################
# disk
######################################################################################

# bats test_tags=disk
@test "disk: should display" {
    run disk list
    assert_success
}
# bats test_tags=disk
@test "disk: should display root only" {
    run bats_pipe disk data / \| wc -l
    assert_output "2"
    assert_success
}
# bats test_tags=disk
@test "disk: should display local" {
    run disk list -l
    assert_success
}
# bats test_tags=disk
@test "disk: with free percent" {
    run disk --free="<99%"
    assert_success
}

######################################################################################
# uses_lvm
######################################################################################

# bats test_tags=uses_lvm
@test "uses_lvm: should display" {
    run uses_lvm
    lsblk | grep lvm >/dev/null && assert_success || assert_failure
}
