#!/usr/bin/env bats

# bats file_tags=monitoring
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
    if [ -z "$PROMETHEUS_API" ] || [ -z "$PROMETHEUS_HOST" ] || [ -z "$GRAFANA_API" ] || [ -z "$GRAFANA_TOKEN" ]; then
        skip "Because prometheus + grafana not set."
    fi
}
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# exporter
######################################################################################

# bats test_tags=exporter
@test "exporter: should get exporter list" {
    run exporter
    assert_success
    assert_output -p ":9100/metrics"
}
# bats test_tags=exporter
@test "exporter: should get exporter list for one job type" {
    run exporter job=node
    assert_success
    assert_output -p ":9100/metrics"
}

######################################################################################
# scrape
######################################################################################

# bats test_tags=scrape
@test "scrape: should scrape all values" {
    url="$(exporter job=node | head -1 | cut -f1)"
    run scrape "$url"
    assert_success
    assert_output -p "node_network_up"
}
# bats test_tags=scrape
@test "scrape: should scrape pattern" {
    url="$(exporter job=node | head -1 | cut -f1)"
    run scrape "$url" node_network_up
    assert_success
    assert_output -p "node_network_up"
}

######################################################################################
# alerts
######################################################################################

# bats test_tags=alerts
@test "alerts: should get empty list" {
    run alerts -i not-existing.host.microschrot.com
    assert_success
}
