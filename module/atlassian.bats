#!/usr/bin/env bats

# bats file_tags=atlassian
setup_file() {
    load $BASHLIB_HOME/loader
    if [ -z "$ATLASSIAN_USER" ] || [ -z "$ATLASSIAN_TOKEN" ]; then
        skip "Because atlassian access is not set."
    fi
}
setup() {
    load "../bats-support/load"
    load "../bats-assert/load"
    load $BASHLIB_HOME/loader
}

# bats test_tags=confluence
@test "confluence: should find entry" {
    if [ -z "$CONFLUENCE_API" ]; then
        skip "Because Confluence API not set."
    fi
    run confluence 677347344
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
