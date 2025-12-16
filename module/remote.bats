#!/usr/bin/env bats

# bats file_tags=remote
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    # check if it should completely skip
    [ -n "$TEST_SERVER" ] || skip "Because a remote TEST_SERVER is needed."
    timeout 2 nc -zv "$TEST_SERVER" 22 &>/dev/null || skip "Because the remote $TEST_SERVER:22 is not reachable."
    # setup
    export server=${TEST_SERVER:-}
}
setup() {
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# remote
######################################################################################

# bats test_tags=remote
@test "remote: should get hostname of remote host" {
    run remote hostname
    assert_output "$server"
    assert_success
}
# bats test_tags=remote
@test "remote: with piped message" {
    run bats_pipe echo hostname \| remote
    assert_output "$server"
    assert_success
}
# bats test_tags=remote
@test "remote: with failed code" {
    run remote false
    assert_failure
}

# bats test_tags=remote
@test "remote: should get hostname of remote host (with terminal)" {
    run remote --terminal hostname
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote
@test "remote: with piped message (with terminal)" {
    run bats_pipe echo hostname \| remote --terminal
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote
@test "remote: with failed code (with terminal)" {
    run remote --terminal false
    assert_failure
}

# bats test_tags=remote
@test "remote: should get hostname of remote host (with terminal, line-based)" {
    run remote --terminal --line-based hostname
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote
@test "remote: with piped message (with terminal, line-based)" {
    run bats_pipe echo hostname \| remote --terminal --line-based
    assert_output -p "$server"
    assert_success
}

# bats test_tags=remote
@test "remote: with simple code (file)" {
    file=$(mktemp)
    echo "hostname" >"$file"
    run remote --file "$file"
    assert_output "$server"
    assert_success
    rm "$file"
}

######################################################################################
# upload
######################################################################################

# bats test_tags=upload
@test "upload: with simple file" {
    file=$(mktemp)
    echo "hostname" >"$file"
    run upload "$file" /home/operator/test
    assert_success
    rm "$file"
    run remote cat /home/operator/test
    assert_output hostname
    remote rm /home/operator/test
}

######################################################################################
# download
######################################################################################

# bats test_tags=download
@test "download: with simple file" {
    skip
    run bats_pipe echo "hostname" \| remote tee /home/operator/test
    assert_success
    file=$(mktemp)
    run download /home/operator/test "$file"
    assert_success
}

