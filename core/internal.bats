#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=internal
setup() {
    load "$BASHLIB_HOME/tests/bats"
}

######################################################################################
# _deprecated
######################################################################################

# bats test_tags=_deprecated
@test "_deprecated: with message" {
    DEBUG="" run _deprecated "no longer used"
    assert_output  --regexp "DEPRECATED: bats_merge_stdout_and_stderr at run in .* no longer used"
    assert_failure
}
# bats test_tags=_deprecated
@test "_deprecated: with only warning" {
    DEBUG="" run _deprecated "no longer used" warn
    assert_output  --regexp "DEPRECATED: bats_merge_stdout_and_stderr at run in .* no longer used"
    assert_success
}

######################################################################################
# _stacktrace
######################################################################################

# bats test_tags=_stacktrace
@test "_stacktrace: show" {
    DEBUG="" run _stacktrace
    assert_output ""
    assert_success
}
