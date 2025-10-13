#!/usr/bin/env bats

# bats file_tags=date
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

# bats test_tags=now
@test "now: should get timestamp" {
    run now
    assert [ "$output" -gt 1759080122 ]
    assert [ "$output" -lt 4102441200 ]
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=date_diff
@test "date_diff: should get difference of timestamps" {
    start=$(now)
    run date_diff $start $((start + 3))
    assert_output 3
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_diff
@test "date_diff: should get difference of date strings" {
    start=$(now)
    run date_diff "2025-10-01 12:00" "2025-10-01 13:00"
    assert_output 3600
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=date_format
@test "date_format: format date as iso" {
    start=$(now)
    run date_format iso-date "2025-10-01 12:00"
    assert_output "2025-10-01"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_format
@test "date_format: format date as full iso with seconds" {
    start=$(now)
    run date_format iso "2025-10-01 12:00"
    assert_output "2025-10-01T12:00:00+02:00"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_format
@test "date_format: format date with custom format" {
    start=$(now)
    run date_format +%Y "2025-10-01 12:00"
    assert_output "2025"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_format
@test "date_format: format date as UTC ISO" {
    start=$(now)
    run date_format zulu "2025-10-01 12:00 CEST"
    assert_output "2025-10-01T10:00:00Z"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_format
@test "date_format: format date as sql (iso with spaces)" {
    start=$(now)
    run date_format sql "2025-10-01 12:00"
    assert_output "2025-10-01 12:00:00"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=date_format
@test "date_format: format date as unix timestamp" {
    start=$(now)
    run date_format unix "2025-10-01 12:00"
    assert_output 1759312800
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
