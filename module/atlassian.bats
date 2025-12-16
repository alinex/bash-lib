#!/usr/bin/env bats

# bats file_tags=atlassian
setup_file() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    if [ -z "$ATLASSIAN_USER" ] || [ -z "$ATLASSIAN_TOKEN" ]; then
        skip "Because Atlassian access is not set."
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

######################################################################################
# jira
######################################################################################

# bats test_tags=jira
@test "jira: should get issue by key" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    run jira SEC-198
    assert_success
}
# bats test_tags=jira
@test "jira: should get issue by issueId" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    run jira 60162
    assert_success
}
# bats test_tags=jira
@test "jira: fail to get issue by key" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    run jira get NOT-EXISTING-KEY
    assert_failure
}
