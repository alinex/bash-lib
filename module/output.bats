#!/usr/bin/env bats

# bats file_tags=output
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# help
######################################################################################

# bats test_tags=help
@test "help: show message" {
    run help Test "help <heading>" "" "Some text"
    assert_output -p "Test"
    assert_success
}

######################################################################################
# heading
######################################################################################

# bats test_tags=heading
@test "heading: with message as argument" {
    run heading Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=heading
@test "heading: with piped message" {
    run bats_pipe echo Test \| heading
    assert_output -p "Test"
    assert_success
}
@test "heading: with server prefix" {
    server=test-machine run heading Test
    assert_output -p "test-machine"
    assert_output -p "Test"
    assert_success
}

######################################################################################
# critical
######################################################################################

# bats test_tags=critical
@test "critical: with message as argument" {
    run critical Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=critical
@test "critical: with piped message" {
    run bats_pipe echo Test \| critical
    assert_output -p "Test"
    assert_success
}

######################################################################################
# error
######################################################################################

# bats test_tags=error
@test "error: with message as argument" {
    run error Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=error
@test "error: with piped message" {
    run bats_pipe echo Test \| error
    assert_success
    assert_output -p "Test"
}

######################################################################################
# warn
######################################################################################

# bats test_tags=warn
@test "warn: with message as argument" {
    run warn Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=warn
@test "warn: with piped message" {
    run bats_pipe echo Test \| warn
    assert_output -p "Test"
    assert_success
}

######################################################################################
# info
######################################################################################

# bats test_tags=info
@test "info: with message as argument" {
    run info Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=info
@test "info: with piped message" {
    run bats_pipe echo Test \| info
    assert_output -p "Test"
    assert_success
}

######################################################################################
# ok
######################################################################################

# bats test_tags=ok
@test "ok: with message as argument" {
    run ok Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=ok
@test "ok: with piped message" {
    run bats_pipe echo Test \| ok
    assert_output -p "Test"
    assert_success
}

######################################################################################
# invers
######################################################################################

# bats test_tags=invers
@test "invers: with message as argument" {
    run invers Test
    assert_output -p "Test"
    assert_success
}
# bats test_tags=invers
@test "invers: with piped message" {
    run bats_pipe echo Test \| invers
    assert_output -p "Test"
    assert_success
}

######################################################################################
# color
######################################################################################

# bats test_tags=color
@test "color: with message as argument" {
    # shellcheck disable=SC2154
    run color "$CC_RED" Test
    assert_success
    assert_output -p "Test"
}
# bats test_tags=color
@test "color: with piped message" {
    run bats_pipe echo Test \| color "$CC_RED"
    assert_output -p "Test"
    assert_success
}

######################################################################################
# uncolorize
######################################################################################

# bats test_tags=uncolorize
@test "uncolorize: with message as argument" {
    # shellcheck disable=SC2154
    run uncolorize "${CC_RED}Test${CC_RESET}"
    assert_output "Test"
    assert_success
}
# bats test_tags=uncolorize
@test "uncolorize: with piped message" {
    run bats_pipe echo "${CC_RED}Test${CC_RESET}" \| uncolorize
    assert_output "Test"
    assert_success
}

######################################################################################
# html2md
######################################################################################

# bats test_tags=html2md
@test "html2md: with message as argument" {
    run html2md Test
    assert_output "Test"
    assert_success
}
# bats test_tags=html2md
@test "html2md: with piped message" {
    run bats_pipe echo Test \| html2md
    assert_output "Test"
    assert_success
}
# bats test_tags=html2md
@test "html2md: convert arrow" {
    run html2md "&rarr;"
    assert_output "→"
    assert_success
}
# bats test_tags=html2md
@test "html2md: convert umlaut" {
    run html2md "&auml;&ouml;&uuml;&Auml;&Ouml;&Uuml;&szlig;"
    assert_output "äöüÄÖÜß"
    assert_success
}
# bats test_tags=html2md
@test "html2md: convert bold" {
    run html2md "<strong>Text</strong>"
    assert_output "**Text**"
    assert_success
}
# bats test_tags=html2md
@test "html2md: convert line breaks" {
    run html2md "a<br>b<br/>c"
    assert_output $'a\nb\nc'
    assert_success
}
# bats test_tags=html2md
@test "html2md: convert lists" {
    run html2md "<ul><li>one<li>two</ul>"
    assert_output $'- one\n- two'
    assert_success
}
# bats test_tags=html2md
@test "html2md: remove other tags" {
    run html2md "a<span>b"
    assert_output 'ab'
    assert_success
}

######################################################################################
# nocr
######################################################################################

# bats test_tags=nocr
@test "nocr: with message as argument" {
    run nocr $'line1\r\nline2'
    assert_output $'line1\nline2'
    assert_success
}
# bats test_tags=nocr
@test "nocr: with piped message" {
    run bats_pipe echo $'line1\r\nline2' \| nocr
    assert_output $'line1\nline2'
    assert_success
}

######################################################################################
# urlencode
######################################################################################

# bats test_tags=urlencode
@test "urlencode: with message as argument" {
    run urlencode "http://my-server:8080/?secret=1 und 2"
    assert_output "http%3A%2F%2Fmy-server%3A8080%2F%3Fsecret%3D1%20und%202"
    assert_success
}
## bats test_tags=urlencode 
#@test "urlencode: with piped message" {
#    run bats_pipe echo "http://my-server:8080/?secret=1 und 2" \| urlencode
#    assert_output "http%3A%2F%2Fmy-server%3A8080%2F%3Fsecret%3D1%20und%202"
#    assert_success
##}

######################################################################################
# tsv2table
######################################################################################

# bats test_tags=tsv2table
@test "tsv2table: with message as argument" {
    run tsv2table $'col1\tcol2\n1\tone'
    assert_success
    assert_output -p $'col1 col2\n1    one'
}
# bats test_tags=tsv2table
@test "tsv2table: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2table
    assert_success
    assert_output -p $'col1 col2\n1    one'
}

######################################################################################
# tsv2md
######################################################################################

# bats test_tags=tsv2md
@test "tsv2md: with message as argument" {
    run tsv2md $'col1\tcol2\n1\tone'
    assert_output -p $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
}
# bats test_tags=tsv2md
@test "tsv2md: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2md
    assert_output -p $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
}

######################################################################################
# spinner
######################################################################################

# bats test_tags=spinner
@test "spinner: should work" {
    run spinner_start 
    assert_success
}
