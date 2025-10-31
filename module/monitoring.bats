#!/usr/bin/env bats

# bats file_tags=monitoring
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
    load "$BASHLIB_HOME/loader"
}

######################################################################################
# alerts
######################################################################################

# bats test_tags=alerts
@test "alerts: should get empty list" {
    run alerts -i not-existing.host.microschrot.com
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
