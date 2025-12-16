#!/usr/bin/env bats

# bats file_tags=input
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# pause
######################################################################################

# bats test_tags=pause
@test "pause: continue with return" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            pause
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
}
# bats test_tags=pause
@test "pause: continue with g key after 1 second" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=pause
@test "pause: continue with g key" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            pause
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        send "g"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
}
# bats test_tags=pause
@test "pause: with custom title" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            pause GoOn
        "
        log_user 1
        expect "GoOn"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "GoOn"
}
# bats test_tags=pause
@test "pause: with timeout" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            pause --timeout=1
        "
        log_user 1
        expect "Warte bis es weiter geht"
        sleep 1
        expect eof
    '
    assert_success
    assert_output -p "Warte bis es weiter geht"
}
# bats test_tags=pause
@test "pause: with timeout and abort" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            pause --timeout=10 --abort
        "
        log_user 1
        expect "Taste drücken um fortzufahren..."
        send "g"
        expect eof
    '
    assert_success
    assert_output -p "Taste drücken um fortzufahren..."
}

######################################################################################
# confirm
######################################################################################

# bats test_tags=confirm
@test "confirm: answer y" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: answer Y" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: answer j" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: answer J" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: answer n" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: answer N" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: with custom prompt" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
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
}
# bats test_tags=confirm
@test "confirm: with default yes" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            confirm --true
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Ja"
}
# bats test_tags=confirm
@test "confirm: with default no" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            confirm --false
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Nein"
}
# bats test_tags=confirm
@test "confirm: with default no after timeout" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            confirm --false --timeout=1
        "
        log_user 1
        expect "Soll dies durchgeführt werden?"
        sleep 2
        expect eof
    '
    assert_success
    assert_output -p "Nein"
}

######################################################################################
# ask
######################################################################################

# bats test_tags=ask
@test "ask: default-format (string)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask
        "
        log_user 1
        expect "Gib eine kurze Zeile ein:"
        send "test\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine kurze Zeile ein:"
    assert_output -p "test"
}
# bats test_tags=ask
@test "ask: string (not empty)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask string
        "
        log_user 1
        expect "Gib eine kurze Zeile ein:"
        send "\ntest\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine kurze Zeile ein:"
    assert_output -p "test"
}
# bats test_tags=ask
@test "ask: string (empty)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask string --empty
        "
        log_user 1
        expect "Gib eine kurze Zeile ein []:"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine kurze Zeile ein []:"
}
# bats test_tags=ask
@test "ask: string with custom question" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask string \"What to do?\"
        "
        log_user 1
        expect "What to do?"
        send "test\n"
        expect eof
    '
    assert_success
    assert_output -p "What to do?"
    assert_output -p "test"
}
# bats test_tags=ask
@test "ask: with default value" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask string --default=test
        "
        log_user 1
        expect "Gib einen Kurztext ein [test]:"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib einen Kurztext ein [test]:"
    assert_output -p "test"
}
# bats test_tags=ask
@test "ask: with default value and timeout" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask string --default=test --timeout=1
        "
        log_user 1
        expect "Gib einen Kurztext ein [test]:"
        sleep 2
        expect eof
    '
    assert_success
    assert_output -p "Gib einen Kurztext ein [test]:"
    assert_output -p "test"
}
# bats test_tags=ask
@test "ask: integer" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask integer
        "
        log_user 1
        expect "Gib eine Nummer ein:"
        send -- "-1g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Nummer ein:"
    assert_output -p "123"
}
# bats test_tags=ask
@test "ask: integer with negative" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask integer --allow-negative
        "
        log_user 1
        expect "Gib eine Nummer ein:"
        send -- "-1g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Nummer ein:"
    assert_output -p "-123"
}
# bats test_tags=ask
@test "ask: number (like integer)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask number
        "
        log_user 1
        expect "Gib eine Nummer ein:"
        send -- "-1g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Nummer ein:"
    assert_output -p "123"
}
# bats test_tags=ask
@test "ask: float with integer" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask float
        "
        log_user 1
        expect "Gib eine Fließkommazahl ein:"
        send -- "-1g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Fließkommazahl ein:"
    assert_output -p "123"
}
# bats test_tags=ask
@test "ask: float" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask float
        "
        log_user 1
        expect "Gib eine Fließkommazahl ein:"
        send -- "-1.g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Fließkommazahl ein:"
    assert_output -p "1.23"
}
# bats test_tags=ask
@test "ask: float (, as decimal separator)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask float
        "
        log_user 1
        expect "Gib eine Fließkommazahl ein:"
        send -- "-1,,g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Fließkommazahl ein:"
    assert_output -p "1.23"
}
# bats test_tags=ask
@test "ask: float (allow negative)" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask float --allow-negative
        "
        log_user 1
        expect "Gib eine Fließkommazahl ein:"
        send -- "-1,,g2h   3\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib eine Fließkommazahl ein:"
    assert_output -p "-1.23"
}
# bats test_tags=ask
@test "ask: password" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            ask password
        "
        log_user 1
        expect "Gib das Passwort ein:"
        send -- "123456\n"
        expect eof
    '
    assert_success
    assert_output -p "Gib das Passwort ein:"
    #assert_output -p "******"
}

######################################################################################
# _password_strength
######################################################################################

# bats test_tags=_password_strength
@test "_password_strength: 123 as bad" {
    run _password_strength 123
    assert_success
    assert_output "8"
}
# bats test_tags=_password_strength
@test "_password_strength: Password1 as weak" {
    run _password_strength Password1
    assert_success
    assert_output "27"
}
# bats test_tags=_password_strength
@test "_password_strength: AmESadSsAdS as good" {
    run _password_strength AmESadSsAdS
    assert_success
    assert_output "64"
}
# bats test_tags=_password_strength
@test "_password_strength: N!7rYxQ2#klOP as strong" {
    run _password_strength N!7rYxQ2#klOP
    assert_success
    assert_output "86"
}

######################################################################################
# choose
######################################################################################

# bats test_tags=choose
@test "choose: list" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three
        "
        log_user 1
        expect "Wähle eine der obigen Optionen:"
        send "1"
        expect eof
    '
    assert_success
    assert_output -p "1) one"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "one" ]
}
# bats test_tags=choose
@test "choose: list through stdin" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            echo -e \"one\ntwo\nthree\" | choose
        "
        log_user 1
        expect "Wähle eine der obigen Optionen:"
        send "1"
        expect eof
    '
    assert_success
    assert_output -p "1) one"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "one" ]
}
# bats test_tags=choose
@test "choose: with title" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three --title=Choose
        "
        log_user 1
        expect "Wähle eine der obigen Optionen:"
        send "1\n"
        expect eof
    '
    assert_success
    assert_output -p "Choose"
    assert_output -p "1) one"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "one" ]
}
# bats test_tags=choose
@test "choose: with additional name in entry" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two \"three|nr.3\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen:"
        send "3\n"
        expect eof
    '
    assert_success
    assert_output -p "3) nr.3"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "three" ]
}
# bats test_tags=choose
@test "choose: with exit option" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three --exit=Close
        "
        log_user 1
        expect "Wähle eine der obigen Optionen:"
        send "x\n"
        expect eof
    '
    assert_success
    assert_output -p "1) one"
    assert_output -p "x) Close"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "exit" ]
}
# bats test_tags=choose
@test "choose: with default number" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three --default=2
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "1) one"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "two" ]
}
# bats test_tags=choose
@test "choose: with default key" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three --default=three
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "1) one"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "three" ]
}
# bats test_tags=choose
@test "choose: with default name" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two \"three|nr.3\" --default=nr.3
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\n"
        expect eof
    '
    assert_success
    assert_output -p "3) nr.3"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "three" ]
}
# bats test_tags=choose
@test "choose: with default after timeout" {
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            choose one two three --default=2 --timeout=1
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        sleep 2
        expect eof
    '
    assert_success
    assert_output -p "2) two"
    last="$(tail -1 <<<"$output" | nocr)"
    assert [ "$last" = "two" ]
}

######################################################################################
# tasks
######################################################################################

# bats test_tags=tasks
@test "tasks: fixed tasks" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks \"task1|run task 1\" \"task2| run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "1x"
        expect eof
    '
    assert_success
    assert_output -p "task1"
}
# bats test_tags=tasks
@test "tasks: read from stdin" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            echo -e \"task1|run task 1\ntask2| run task 2\" | tasks
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "1x"
        expect eof
    '
    assert_success
    assert_output -p "task1"
}
# bats test_tags=tasks
@test "tasks: with title" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks --title=ToDo \"task1|run task 1\" \"task2| run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "1x"
        expect eof
    '
    assert_success
    assert_output -p "ToDo"
    assert_output -p "task1"
}
# bats test_tags=tasks
@test "tasks: with default as number" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks --default=1 \"task1|run task 1\" \"task2| run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\nx"
        expect eof
    '
    assert_success
    assert_output -p "task1"
}
# bats test_tags=tasks
@test "tasks: with default as key" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks --default=task2 \"task1|run task 1\" \"task2| run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\nx"
        expect eof
    '
    assert_success
    assert_output -p "task2"
}
# bats test_tags=tasks
@test "tasks: with default as name" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks --default=\"run task 2\" \"task1|run task 1\" \"task2|run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        send "\nx"
        expect eof
    '
    assert_success
    assert_output -p "task2"
}
# bats test_tags=tasks
@test "tasks: with default after timeout" {
    # shellcheck disable=SC2329
    task1() { echo "task1"; }
    # shellcheck disable=SC2329
    task2() { echo "task2"; }
    run expect -c '
        log_user 0
        spawn bash -c "
            source '"$BASHLIB_HOME"'/loader
            tasks --default=1 --timeout=1 \"task1|run task 1\" \"task2| run task 2\"
        "
        log_user 1
        expect "Wähle eine der obigen Optionen"
        sleep 2
        send "x"
        expect eof
    '
    assert_success
    assert_output -p "task1"
}
# bats test_tags=tasks
@test "tasks: empty tasks will return" {
    run tasks
    assert_success
    assert_output -p "Keine Aufgaben zum Ausführen gefunden."
}
