#!/usr/bin/env bats

# bats file_tags=atlassian
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    if [ -z "$ATLASSIAN_USER" ] || [ -z "$ATLASSIAN_TOKEN" ]; then
        skip "Because atlassian access is not set."
    fi
}
setup() {
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# confluence
######################################################################################

# bats test_tags=confluence
@test "confluence: should find entry" {
    if [ -z "$CONFLUENCE_API" ]; then
        skip "Because Confluence API not set."
    fi
    run confluence 677347344
    assert_success
}
