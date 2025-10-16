#!/usr/bin/env bats

# bats file_tags=monitoring
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

# bats test_tags=alerts
@test "alerts: should get empty list" {
    run alerts -i not-existing.host.microschrot.com
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
