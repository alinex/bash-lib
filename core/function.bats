#!/usr/bin/env bats

# bats file_tags=function
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

# bats test_tags=input
@test "input: as arguments into line" {
    run input one two three
    assert_output 'one two three'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=input
@test "input: from stdin into line" {
    run bats_pipe echo one two three \| input
    assert_output 'one two three'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=input_args
@test "input_args: as arguments into line" {
    run input_args 1 title one two three
    assert_output 'one two three'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=input_args
@test "input_args: from stdin into line" {
    run bats_pipe echo one two three \| input_args 1 title
    assert_output 'one two three'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=input_lines
@test "input_lines: as arguments into lines" {
    run input_lines one two three
    assert_output $'one\ntwo\nthree'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=input_lines
@test "input_lines: from stdin into lines" {
    run bats_pipe echo one two three \| input_lines
    assert_output 'one two three'
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

# bats test_tags=option_parse
@test "option_parse: parse example specification" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -n "Alfred" --age 34 -h captain
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: options at the end" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" captain -n "Alfred" --age 34 -h
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: with short spec" {
    run option_parse $'a min +\nb max +\nc die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=option_parse
@test "option_parse: without short name" {
    run option_parse $'- min +\n- max +\n- die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=option_help
@test "option_help: print options from example specification" {
    run option_help "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page"
    assert_output -p "Optionen:"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=mktemp
@test "mktemp: normal behaviour for file" {
    run mktemp
    assert_success
    assert [ -e $output ]
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: normal behaviour for directory" {
    run mktemp -d dir
    assert_success
    assert [ -d $output ]
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: recognizable file" {
    run mktemp test
    assert_success
    assert [ -e $output ]
    assert_output "/tmp/bats-exec-test_test"
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: recognizable file with extension" {
    run mktemp test -e env
    assert_success
    assert [ -e $output ]
    assert_output "/tmp/bats-exec-test_test.env"
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=mktemp
@test "mktemp: recognizable directory" {
    run mktemp testdir -d
    assert_success
    assert [ -d $output ]
    assert_output "/tmp/bats-exec-test_testdir"
    echo $output # use --show-output-of-passing-tests to see it
}
