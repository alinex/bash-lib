#!/usr/bin/env bats

# bats file_tags=input
setup() {
    load "$BASHLIB_HOME/tests/bats-support/load"
    load "$BASHLIB_HOME/tests/bats-assert/load"
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
    echo "$output" # use --show-output-of-passing-tests to see it
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
    echo "$output" # use --show-output-of-passing-tests to see it
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
    echo "$output" # use --show-output-of-passing-tests to see it
}

# bats test_tags=confirm
@test "confirm: answer y" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "y"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: answer Y" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "Y"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: answer j" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "j"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: answer J" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "J"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: answer n" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "n"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Nein"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: answer N" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "N"
        expect eof
    '
    assert_success
    assert_output -p "Soll dies durchgeführt werden?"
    assert_output -p "Nein"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: with custom prompt" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm \"Go on?\"
        "
        log_user 1
        expect "Go on?"
        send "y"
        expect eof
    '
    assert_success
    assert_output -p "Go on?"
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: with default yes" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm --true
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Ja"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: with default no" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm --false
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Nein"
    echo "$output" # use --show-output-of-passing-tests to see it
}
# bats test_tags=confirm
@test "confirm: with default no after timeout" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '$BASHLIB_HOME'/loader
            confirm --false --timeout=1
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        sleep 2
        expect eof
    '
    assert_success
    assert_output -p "Nein"
    echo "$output" # use --show-output-of-passing-tests to see it
}

