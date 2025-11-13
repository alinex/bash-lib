#!/usr/bin/env bats

# bats file_tags=process
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# sudo_allow
######################################################################################

# bats test_tags=sudo_allow
@test "sudo_allow: check call" {
    run sudo_allow date
    assert_success
}

######################################################################################
# sudo
######################################################################################

# bats test_tags=sudo
@test "sudo: call date" {
    run sudo date
    assert_success
}

######################################################################################
# repeat
######################################################################################

# bats test_tags=repeat
@test "repeat: run only once" {
    run repeat 1 echo -n "1"
    assert_success
    assert_output "1"
}
# bats test_tags=repeat
@test "repeat: call multiple times" {
    run repeat 4 echo -n "1"
    assert_success
    assert_output "1111"
}

######################################################################################
# retry
######################################################################################

# bats test_tags=retry
@test "retry: run only once" {
    # shellcheck disable=SC2329
    t() { echo -n "1"; false; }
    run retry 1 t
    assert_failure
    assert_output "1"
}
# bats test_tags=retry
@test "retry: retry 3 times" {
    t() { echo -n "1"; false; }
    run retry 3 t
    assert_failure
    assert_output "111"
}

######################################################################################
# lock
######################################################################################

# bats test_tags=lock
@test "lock: set lock file" {
    lock
    assert [ -e "/tmp/$(basename "$0")_lockfile" ]
    unlock
    assert_success
}

######################################################################################
# lock_exit
######################################################################################

# bats test_tags=lock_exit
@test "lock_exit: set lock file" {
    lock_exit
    assert [ -e "/tmp/$(basename "$0")_lockfile" ]
    unlock
    assert_success
}

######################################################################################
# env_store
######################################################################################

# bats test_tags=env_store
@test "env_store: create file" {
    run env_store
    assert [ -e "/dev/shm/$(basename "$0").env" ]
    assert_success
}

######################################################################################
# random
######################################################################################

# bats test_tags=random
@test "random: number" {
    run random num
    assert_output -e "^[0-9]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: with specified length" {
    run random num 4
    assert_output -e "^[0-9]{4}$"
    assert_success
}
# bats test_tags=random
@test "random: letters" {
    run random letters
    assert_output -e "^[a-z]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: LETTERS" {
    run random LETTERS
    assert_output -e "^[A-Z]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: alpha" {
    run random alpha
    assert_output -e "^[a-zA-Z]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: alphanum" {
    run random alphanum
    assert_output -e "^[a-zA-Z0-9]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: base64" {
    run random base64
    assert_output -e "^[a-zA-Z0-9+/]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: printable" {
    run random printable
    assert_success
}
# bats test_tags=random
@test "random: hex" {
    run random hex
    assert_output -e "^[0-9a-f]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: HEX" {
    run random HEX
    assert_output -e "^[0-9A-F]{16}$"
    assert_success
}
# bats test_tags=random
@test "random: custom pattern" {
    run random "01"
    assert_output -e "^[01]{16}$"
    assert_success
}
