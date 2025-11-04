#!/usr/bin/env bats

# bats file_tags=dns
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME"/loader
    if [ -z "$SERVER" ] || [ -z "$GRAFANA_API" ] || [ -z "$GRAFANA_TOKEN" ]; then
        skip "Because a remote server is needed."
    fi
}
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
    load "$BASHLIB_HOME/loader"
    # test setup
    server=operations.host.cloud.dvb
}
