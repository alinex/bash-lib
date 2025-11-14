#!/usr/bin/env bats
# shellcheck source=config/test-setup.conf

source /dev/null

# bats file_tags=database
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# mongo
######################################################################################

# bats test_tags=mongo
@test "mongo: should get path" {
    # shellcheck disable=SC2034
    server="$TEST_SERVER_MONGO"
    run mongo "" "db.runCommand({ ping: 1 })"
    assert_output -p '"ok":1'
    assert_success
}
