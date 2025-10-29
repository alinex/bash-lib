#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=arguments
setup() {
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
    load $BASHLIB_HOME/loader
}
teardown_file() {
    rm -rf /tmp/bats-exec*
    rm -rf /dev/shm/bats-exec*
}

# bats test_tags=input
@test "input: as arguments into line" {
    run input one two three
    assert_output 'one two three'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=input
@test "input: from stdin into line" {
    run bats_pipe echo one two three \| input
    assert_output 'one two three'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=input_args
@test "input_args: as arguments into line" {
    run input_args 1 title one two three
    assert_output 'one two three'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=input_args
@test "input_args: from stdin into line" {
    run bats_pipe echo one two three \| input_args 1 title
    assert_output 'one two three'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=input_lines
@test "input_lines: as arguments into lines" {
    run input_lines one two three
    assert_output $'one\ntwo\nthree'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=input_lines
@test "input_lines: from stdin into lines" {
    run bats_pipe echo one two three \| input_lines
    assert_output 'one two three'
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=option_parse
@test "option_parse: parse example specification" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -n "Alfred" --age 34 -h captain
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: options at the end" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" captain -n "Alfred" --age 34 -h
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: multiple short options together" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -hn "Alfred" --age 34 captain
    assert_output " -h -n 'Alfred' --age '34' -- 'captain'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: put name and value together" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -h -nAlfred --age=34 captain
    assert_output " -h -n 'Alfred' --age '34' -- 'captain'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: with short spec" {
    run option_parse $'a min +\nb max +\nc die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: without short name" {
    run option_parse $'- min +\n- max +\n- die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=option_help
@test "option_help: print options from example specification" {
    run option_help "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page"
    assert_output -p "Optionen:"
    assert_success
    echo "$output" # use --show-output-of-passing-tests to see it
}
