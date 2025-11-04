#!/usr/bin/env bats

# bats file_tags=process
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
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

