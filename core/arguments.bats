#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=arguments
setup() {
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# option_parse
######################################################################################

# bats test_tags=option_parse
@test "option_parse: parse example specification" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -n "Alfred" --age 34 -h captain
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: options at the end" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" captain -n "Alfred" --age 34 -h
    assert_output " -n 'Alfred' --age '34' -h -- 'captain'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: multiple short options together" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -hn "Alfred" --age 34 captain
    assert_output " -h -n 'Alfred' --age '34' -- 'captain'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: put name and value together" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -h -nAlfred --age=34 captain
    assert_output " -h -n 'Alfred' --age '34' -- 'captain'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: with short spec" {
    run option_parse $'a min +\nb max +\nc die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: without short name" {
    run option_parse $'- min +\n- max +\n- die +' \
    p1 p2 --min 5
    assert_output " --min '5' -- 'p1' 'p2'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: permutation allowed" {
    run option_parse "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -h -nAlfred captain --age=34
    assert_output " -h -n 'Alfred' --age '34' -- 'captain'"
    assert_success
}
# bats test_tags=option_parse
@test "option_parse: permutation disallowed" {
    run option_parse "+
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page" -h -nAlfred captain --age=34
    assert_output " -h -n 'Alfred' -- 'captain' '--age=34'"
    assert_success
}

######################################################################################
# option_help
######################################################################################

# bats test_tags=option_help
@test "option_help: print options from example specification" {
    run option_help "
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page"
    assert_output -p "Optionen:"
    assert_success
}

######################################################################################
# input
######################################################################################

# bats test_tags=input
@test "input: as arguments into line" {
    run input one two three
    assert_output 'one two three'
    assert_success
}

# bats test_tags=input
@test "input: from stdin into line" {
    run bats_pipe echo one two three \| input
    assert_output 'one two three'
    assert_success
}

######################################################################################
# input_args
######################################################################################

# bats test_tags=input_args
@test "input_args: as arguments into line" {
    run input_args 1 title one two three
    assert_output 'one two three'
    assert_success
}
# bats test_tags=input_args
@test "input_args: from stdin into line" {
    run bats_pipe echo one two three \| input_args 1 title
    assert_output 'one two three'
    assert_success
}

######################################################################################
# input_lines
######################################################################################

# bats test_tags=input_lines
@test "input_lines: as arguments into lines" {
    run input_lines one two three
    assert_output $'one\ntwo\nthree'
    assert_success
}
# bats test_tags=input_lines
@test "input_lines: from stdin into lines" {
    run bats_pipe echo one two three \| input_lines
    assert_output 'one two three'
    assert_success
}

######################################################################################
# escape_args
######################################################################################

# bats test_tags=escape_args
@test "escape_args: add backslashes" {
    run escape_args "--free=<6%"
    assert_output "--free=\\<6%"
    assert_success
}
# bats test_tags=escape_args
@test "escape_args: arguments with spaces" {
    run escape_args "This should be one argument"
    assert_output "This\\ should\\ be\\ one\\ argument"
    assert_success
}
