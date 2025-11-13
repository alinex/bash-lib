#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=date
setup() {
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# now
######################################################################################

# bats test_tags=now
@test "now: should get timestamp" {
    run now
    assert [ "$output" -gt 1759080122 ]
    assert [ "$output" -lt 4102441200 ]
    assert_success
}

######################################################################################
# date_diff
######################################################################################

# bats test_tags=date_diff
@test "date_diff: should get difference of timestamps" {
    start=$(now)
    run date_diff "$start" $((start + 3))
    assert_output 3
    assert_success
}
# bats test_tags=date_diff
@test "date_diff: should get difference of date strings" {
    start=$(now)
    run date_diff "2025-10-01 12:00" "2025-10-01 13:00"
    assert_output 3600
    assert_success
}

######################################################################################
# date_format
######################################################################################

# bats test_tags=date_format
@test "date_format: format date as iso" {
    start=$(now)
    run date_format iso-date "2025-10-01 12:00"
    assert_output "2025-10-01"
    assert_success
}
# bats test_tags=date_format
@test "date_format: format date as full iso with seconds" {
    start=$(now)
    run date_format iso "2025-10-01 12:00"
    assert_output "2025-10-01T12:00:00+02:00"
    assert_success
}
# bats test_tags=date_format
@test "date_format: format date with custom format" {
    start=$(now)
    run date_format +%Y "2025-10-01 12:00"
    assert_output "2025"
    assert_success
}
# bats test_tags=date_format
@test "date_format: format date as UTC ISO" {
    start=$(now)
    run date_format zulu "2025-10-01 12:00 CEST"
    assert_output "2025-10-01T10:00:00Z"
    assert_success
}
# bats test_tags=date_format
@test "date_format: format date as sql (iso with spaces)" {
    start=$(now)
    run date_format sql "2025-10-01 12:00"
    assert_output "2025-10-01 12:00:00"
    assert_success
}
# bats test_tags=date_format
@test "date_format: format date as unix timestamp" {
    start=$(now)
    run date_format unix "2025-10-01 12:00"
    assert_output 1759312800
    assert_success
}

######################################################################################
# duration_format
######################################################################################

# bats test_tags=duration_format
@test "duration_format: return number" {
    run duration_format seconds "5"
    assert_output 5
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse seconds" {
    run duration_format seconds "5s"
    assert_output 5
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse minutes" {
    run duration_format seconds "5m"
    assert_output 300
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse hours" {
    run duration_format seconds "1h"
    assert_output 3600
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse days" {
    run duration_format seconds "1d"
    assert_output 86400
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse weeks" {
    run duration_format seconds "1w"
    assert_output 604800
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse combined" {
    run duration_format seconds "1h30m"
    assert_output 5400
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse ignore +" {
    run duration_format seconds "+1h30m"
    assert_output 5400
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse negative" {
    run duration_format seconds "-5"
    assert_output -5
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse cnegative ombined" {
    run duration_format seconds "-1h30m"
    assert_output -5400
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: formats as human for seconds" {
    run duration_format human 5
    assert_output "5s"
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: formats as human for combined" {
    run duration_format human 5400
    assert_output "1h 30m"
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: formats as human for negative" {
    run duration_format human -5400
    assert_output "-1h 30m"
    assert_success
}
# bats test_tags=duration_format
@test "duration_format: parse combined with spaces" {
    run duration_format seconds "1h 30m"
    assert_output 5400
    assert_success
}

######################################################################################
# timer_start
######################################################################################

# bats test_tags=timer_start
@test "timer_start: start timer without error" {
    run timer_start
    assert_success
}

######################################################################################
# timer_stop
######################################################################################

# bats test_tags=timer_stop
@test "timer_stop: get time since start" {
    run timer_stop
    assert_success
}
