#!/usr/bin/env bats

# bats file_tags=output
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
    load .loader
}

# bats test_tags=heading
@test "heading: with message as argument" {
    run heading Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=heading
@test "heading: with piped message" {
    run bats_pipe echo Test \| heading
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
@test "heading: with server prefix" {
    server=test-machine run heading Test
    assert_output -p "test-machine"
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=critical
@test "critical: with message as argument" {
    run critical Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=critical
@test "critical: with piped message" {
    run bats_pipe echo Test \| critical
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=error
@test "error: with message as argument" {
    run error Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=error
@test "error: with piped message" {
    run bats_pipe echo Test \| error
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    assert_output -p "Test"
}

# bats test_tags=warn
@test "warn: with message as argument" {
    run warn Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=warn
@test "warn: with piped message" {
    run bats_pipe echo Test \| warn
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=info
@test "info: with message as argument" {
    run info Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=info
@test "info: with piped message" {
    run bats_pipe echo Test \| info
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=ok
@test "ok: with message as argument" {
    run ok Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ok
@test "ok: with piped message" {
    run bats_pipe echo Test \| ok
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=invers
@test "invers: with message as argument" {
    run invers Test
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=invers
@test "invers: with piped message" {
    run bats_pipe echo Test \| invers
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=color
@test "color: with message as argument" {
    run color $CC_RED Test
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    assert_output -p "Test"
}
# bats test_tags=color
@test "color: with piped message" {
    run bats_pipe echo Test \| color $CC_RED
    assert_output -p "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=debug
@test "debug: do nothing in normal mode" {
    run debug Test
    assert_output ""
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=debug
@test "debug: output in debug mode" {
    DEBUG=1 run debug Test
    assert_output Test
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=uncolorize
@test "uncolorize: with message as argument" {
    run uncolorize "${CC_RED}Test${CC_RESET}"
    assert_output "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=uncolorize
@test "uncolorize: with piped message" {
    run bats_pipe echo "${CC_RED}Test${CC_RESET}" \| uncolorize
    assert_output "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=html2md
@test "html2md: with message as argument" {
    run html2md Test
    assert_output "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: with piped message" {
    run bats_pipe echo Test \| html2md
    assert_output "Test"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: convert arrow" {
    run html2md "&rarr;"
    assert_output "→"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: convert umlaut" {
    run html2md "&auml;&ouml;&uuml;&Auml;&Ouml;&Uuml;&szlig;"
    assert_output "äöüÄÖÜß"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: convert bold" {
    run html2md "<strong>Text</strong>"
    assert_output "**Text**"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: convert line breaks" {
    run html2md "a<br>b<br/>c"
    assert_output $'a\nb\nc'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: convert lists" {
    run html2md "<ul><li>one<li>two</ul>"
    assert_output $'- one\n- two'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=html2md
@test "html2md: remove other tags" {
    run html2md "a<span>b"
    assert_output 'ab'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=nocr
@test "nocr: with message as argument" {
    run nocr $'line1\r\nline2'
    assert_output $'line1\nline2'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=nocr
@test "nocr: with piped message" {
    run bats_pipe echo $'line1\r\nline2' \| nocr
    assert_output $'line1\nline2'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=urlencode
@test "urlencode: with message as argument" {
    run urlencode "http://my-server:8080/?secret=1 und 2"
    assert_output "http%3A%2F%2Fmy-server%3A8080%2F%3Fsecret%3D1%20und%202"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=urlencode
@test "urlencode: with piped message" {
    run bats_pipe echo "http://my-server:8080/?secret=1 und 2" \| urlencode
    assert_output "http%3A%2F%2Fmy-server%3A8080%2F%3Fsecret%3D1%20und%202"
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=tsv2table
@test "tsv2table: with message as argument" {
    run tsv2table $'col1\tcol2\n1\tone'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    assert_output $'col1 col2\n1    one'
}
# bats test_tags=tsv2table
@test "tsv2table: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2table
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    assert_output $'col1 col2\n1    one'
}

# bats test_tags=tsv2md
@test "tsv2md: with message as argument" {
    run tsv2md $'col1\tcol2\n1\tone'
    assert_output $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=tsv2md
@test "tsv2md: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2md
    assert_output $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=pause
@test "pause: should work by pressing any key" {
    read() { key=""; } # mocking read
    run pause
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=ask_no
@test "ask_no: should work by pressing <return>" {
    read() { yn=""; } # mocking read
    run ask_no
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing n" {
    read() { yn="n"; } # mocking read
    run ask_no
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing N" {
    read() { yn="N"; } # mocking read
    run ask_no
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing j" {
    read() { yn="j"; } # mocking read
    run ask_no
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing J" {
    read() { yn="J"; } # mocking read
    run ask_no
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing y" {
    read() { yn="y"; } # mocking read
    run ask_no
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_no
@test "ask_no: should work by pressing Y" {
    read() { yn="Y"; } # mocking read
    run ask_no
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=ask_yes
@test "ask_yes: should work by pressing <return>" {
    read() { yn=""; } # mocking read
    run ask_yes
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing n" {
    read() { yn="n"; } # mocking read
    run ask_yes
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing N" {
    read() { yn="N"; } # mocking read
    run ask_yes
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing j" {
    read() { yn="j"; } # mocking read
    run ask_yes
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing J" {
    read() { yn="J"; } # mocking read
    run ask_yes
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing y" {
    read() { yn="y"; } # mocking read
    run ask_yes
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=ask_yes
@test "ask_yes: should work by pressing Y" {
    read() { yn="Y"; } # mocking read
    run ask_yes
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=ask_input
@test "ask_input: should read one line" {
    read() { answer="Test"; } # mocking read
    run ask_input
    assert_output Test
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# choose not mockable because of duplicate use of read
