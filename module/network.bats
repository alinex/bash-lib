#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=network
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
    # declare global used variables
    declare -g _ip_extern_json
}

######################################################################################
# ip_intern
######################################################################################

# bats test_tags=ip_intern
@test "ip_intern: with default format" {
    run ip_intern
    assert_output -e "^[0-9]+\.[0-9]+.[0-9]+.[0-9]+$"
    assert_success
}
# bats test_tags=ip_intern
@test "ip_intern: with main format" {
    run ip_intern main
    assert_output -e "^[0-9]+\.[0-9]+.[0-9]+.[0-9]+$"
    assert_success
}
# bats test_tags=ip_intern
@test "ip_intern: with data format" {
    run ip_intern data
    assert_output -p $'IP\tSchnittstelle'
    assert_output -e "[0-9]+\.[0-9]+.[0-9]+.[0-9]+"
    assert_success
}

######################################################################################
# ip_pattern
######################################################################################

# bats test_tags=ip_pattern
@test "ip_pattern: check provider PS" {
    run ip_pattern provider 10.12.48.10
    assert_output "PS"
    assert_success
}
# bats test_tags=ip_pattern
@test "ip_pattern: check provider RT" {
    run ip_pattern provider 172.27.0.103
    assert_output "RT"
    assert_success
}
# bats test_tags=ip_pattern
@test "ip_pattern: check segment" {
    run ip_pattern segment 10.12.48.10
    assert_output "user"
    assert_success
}
# bats test_tags=ip_pattern
@test "ip_pattern: check vmware RT" {
    run ip_pattern vmware 172.27.0.103
    assert_output -p "https"
    assert_success
}
# bats test_tags=ip_pattern
@test "ip_pattern: access undefined array" {
    run ip_pattern undefined 172.27.0.103
    assert_failure
}

######################################################################################
# ip_extern
######################################################################################

# bats test_tags=ip_extern
@test "ip_extern: get ip" {
    run ip_extern ip
    assert_output -e "."
    assert_success
}
# bats test_tags=ip_extern
@test "ip_extern: get all data" {
    run ip_extern data
    assert_output -p "ip"
    assert_output -p "city"
    assert_success
}
