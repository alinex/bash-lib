#!/usr/bin/env bats

# bats file_tags=misc
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}
teardown_file() {
    rm -rf /tmp/bats-exec*
    rm -rf /dev/shm/bats-exec*
}

# bats test_tags=debug
@test "debug: do nothing if no debugging" {
    DEBUG= run debug Test
    assert_output ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=debug
@test "debug: show level 1" {
    DEBUG=1 run debug Test
    assert [ "$(uncolorize "$output")" = "> run                  Test" ]
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=debug
@test "debug: do not show level 2" {
    DEBUG=1 run debug 2 Test
    assert_output ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=debug
@test "debug: show func run" {
    DEBUG=run run debug Test
    assert [ "$(uncolorize "$output")" = "> run                  Test" ]
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=debug
@test "debug: do not show func test" {
    DEBUG=test run debug Test
    assert_output ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=die
@test "die: with message as argument" {
    run die Failed
    assert_output -p "Failed"
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=die
@test "die: with piped message" {
    run bats_pipe echo Failed \| die
    assert_output -p "Failed"
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=mktemp
@test "mktemp: for file" {
    run mktemp
    assert_success
    assert [ -e $output ]
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: for directory" {
    run mktemp -d dir
    assert_success
    assert [ -d $output ]
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: in memory" {
    run mktemp -m test
    assert_success
    assert [ -e $output ]
    assert_output "/dev/shm/bats-exec-test_test"
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: with identifier" {
    run mktemp test
    assert_success
    assert [ -e $output ]
    assert_output "/tmp/bats-exec-test_test"
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: with extension" {
    run mktemp test -e env
    assert_success
    assert [ -e $output ]
    assert_output "/tmp/bats-exec-test_test.env"
    echo $output # use --show-output-of-passing-tests to see it
}
