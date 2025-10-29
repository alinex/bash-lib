#!/usr/bin/env bats

# bats file_tags=software
setup() {
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
    load $BASHLIB_HOME/loader
}

# bats test_tags=semver
@test "semver: should parse 2.8.3" {
    run semver 2.8.3
    assert_output $'2\n8\n3'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 1.2.10-1ubuntu5.7" {
    run semver 1.2.10-1ubuntu5.7
    assert_output $'1\n2\n10\n1ubuntu5.7'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse v1.2.3-alpha.10.beta.0+build.unicorn.rainbow" {
    run semver v1.2.3-alpha.10.beta.0+build.unicorn.rainbow
    assert_output $'1\n2\n3\nalpha.10.beta.0\nbuild.unicorn.rainbow'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 4:23.08.5-0ubuntu4.1" {
    run semver 4:23.08.5-0ubuntu4.1
    assert_output $'23\n08\n5\n0ubuntu4.1'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 3.20250311.1ubuntu0.24.04.1" {
    run semver 3.20250311.1ubuntu0.24.04.1
    assert [ "$output" = $'3\n20250311\n1\n\nubuntu0.24.04.1' ]
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 20161207-12" {
    run semver 20161207-12
    assert_output $'20161207\n\n\n12'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 13ubuntu10.3" {
    run semver 13ubuntu10.3
    assert_output $'13\n\n\n\nubuntu10.3'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 3.6.3build1" {
    run semver 3.6.3build1
    assert_output $'3\n6\n3\n\nbuild1'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver
@test "semver: should parse 3-beta1" {
    run semver "3-beta1"
    assert_output $'3\n\n\nbeta1'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=semver_diff
@test "semver_diff: detect same version 3.8.14" {
    v1="$(semver 3.8.14)"
    v2="$(semver 3.8.14)"
    run semver_diff "$v1" "$v2"
    assert_output 0
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer major 3.8.14 -> 4.1.2" {
    v1="$(semver 3.8.14)"
    v2="$(semver 4.1.2)"
    run semver_diff "$v1" "$v2"
    assert [ $((output / 1000000000)) -eq 1 ]
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect older major 3.8.14 -> 2.156.2-pre2" {
    v1="$(semver 3.8.14)"
    v2="$(semver 2.156.2-pre2)"
    run semver_diff "$v1" "$v2"
    assert [ $((output / 1000000000)) -eq -1 ]
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer minor 3.8.14 -> 3.25.0" {
    v1="$(semver 3.8.14)"
    v2="$(semver 3.25.0)"
    run semver_diff "$v1" "$v2"
    assert [ $((output / 1000000)) -eq 17 ]
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer patch 3.8.14 -> 3.8.614" {
    v1="$(semver 3.8.14)"
    v2="$(semver 3.8.614)"
    run semver_diff "$v1" "$v2"
    assert [ $((output / 1000)) -eq 600 ]
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer patch (over 999) 3.8.14 -> 3.8.4614" {
    v1="$(semver 3.8.14)"
    v2="$(semver 3.8.4614)"
    run semver_diff "$v1" "$v2"
    assert [ $((output / 1000)) -eq 999 ]
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer 3-beta1 -> 3-rc2" {
    v1="$(semver "3-beta1")"
    v2="$(semver "3-rc2")"
    run semver_diff "$v1" "$v2"
    assert_output 10
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: detect newer 3bui134 -> 3build1732" {
    v1="$(semver 3bui134)"
    v2="$(semver 3build1732)"
    run semver_diff "$v1" "$v2"
    assert_output 1
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: using unparsed version strings" {
    v1="3.8.14"
    v2="3.8.15"
    run semver_diff "$v1" "$v2"
    assert_output 1000
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=semver_diff
@test "semver_diff: output human analysis" {
    v1="3.8.14"
    v2="3.8.15"
    run semver_diff -h "$v1" "$v2"
    assert_output "3.8.14 -> 3.8.15 ist ein upgrade von 1 Patch Level(n)"
    assert_failure
    echo "$output" # use --show-output-of-passing-tests to see it
}
