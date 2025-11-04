#!/usr/bin/env bats

# bats file_tags=remote
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats"
    # check if it should completely skip
    [ -n "$TEST_SERVER" ] || skip "Because a remote TEST_SERVER is needed."
    timeout 2 nc -zv "$TEST_SERVER" 22 &>/dev/null || skip "Because the remote $TEST_SERVER:22 is not reachable."
    # setup
    export server=${TEST_SERVER:-}
}
setup() {
    load "$BASHLIB_HOME/tests/bats"
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

######################################################################################
# remote_term
######################################################################################

# bats test_tags=remote_term
@test "remote_term: should get hostname of remote host" {
    run remote_term hostname
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote_term
@test "remote_term: with piped message" {
    run bats_pipe echo hostname \| remote
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote_term_line
@test "remote_term_line: with failed code" {
    run remote_term_line false
    assert_failure
}

######################################################################################
# remote_term_line
######################################################################################

# bats test_tags=remote_term_line
@test "remote_term_line: should get hostname of remote host" {
    run remote_term_line hostname
    assert_output -p "$server"
    assert_success
}
# bats test_tags=remote_term_line
@test "remote_term_line: with piped message" {
    run bats_pipe echo hostname \| remote
    assert_output -p "$server"
    assert_success
}

######################################################################################
# remote_file
######################################################################################

# bats test_tags=remote_file
@test "remote_file: with simple code" {
    file=$(mktemp)
    echo "hostname" >"$file"
    run remote_file "$file"
    assert_output "$server"
    assert_success
    rm "$file"
}
# bats test_tags=remote_file
@test "remote_file: with piped filename" {
    file=$(mktemp)
    echo "hostname" >"$file"
    run bats_pipe echo "$file" \| remote_file
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
#    assert [ -e "$file" ]
#    rm $file
#    remote rm /home/operator/test
#}

######################################################################################
# remote_install
######################################################################################

# bats test_tags=remote_install
@test "remote_install: should do nothing if installed" {
    skip
    run remote_install htop
    assert_output ""
    assert_success
}

######################################################################################
# remote_df
######################################################################################

# bats test_tags=remote_df
@test "remote_df: should display table" {
    run remote_df
    assert [ -n "$output" ]
    assert_success
}
# bats test_tags=remote_df
@test "remote_df: should display only specific entries" {
    run remote_df /mnt/acs /mnt/tea
    assert [ "$(wc -l <<<"$output")" -eq 3 ]
    assert_success
}
