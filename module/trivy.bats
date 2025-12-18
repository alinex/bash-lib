#!/usr/bin/env bats

# bats file_tags=trivy
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
# trivy
######################################################################################

