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
    run jira get SEC-198
    assert_success
    assert_output -p '"key":"SEC-198"'
}
# bats test_tags=jira
@test "jira: should get issue by issueId" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    run jira get 60162
    assert_success
    assert_output -p '"key":"SEC-198"'
}
# bats test_tags=jira
@test "jira: fail to get issue by key" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    run jira get NOT-EXISTING-KEY
    assert_failure
}
# bats test_tags=jira
@test "jira: should search by title" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    SECURITY_BOARD_ID=10134
    cve=CVE-2017-5336
    jql="project = ${SECURITY_BOARD_ID} AND summary ~ $cve ORDER BY created ASC"
    run jira search "$jql"
    assert_success
    assert_output 60162
}
# bats test_tags=jira
@test "jira: should create json" {
    if [ -z "$JIRA_HOST" ]; then
        skip "Because JIRA_HOST not set."
    fi
    SECURITY_BOARD_ID=10134
    export fields=""
    run jira json fields set project 10123
    assert_success
    assert [ "$fields" = '{"project": 10123}' ]
}
