#!/usr/bin/env bats

# bats file_tags=input
setup() {
    load "../bats-support/load"
    load "../bats-assert/load"
    load $BASHLIB_HOME/loader
}

# bats test_tags=pause
@test "pause: continue with return" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            pause
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=pause
@test "pause: continue with g key after 1 second" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            pause
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        sleep 1
        send "g"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=pause
@test "pause: continue with g key" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            pause
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        send "g"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
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
