#!/usr/bin/env bats

# bats file_tags=misc
setup() {
    load $BASHLIB_HOME/bats-support/load.bash
    load $BASHLIB_HOME/bats-assert/load.bash
    load $BASHLIB_HOME/loader
}

# bats test_tags=_deprecated
@test "_deprecated: with message" {
    DEBUG= run _deprecated "no longer used"
    assert_output -p "DEPRECATED: _deprecated at run in /usr/lib/bats-core/test_functions.bash:383 no longer used"
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_stacktrace
@test "_stacktrace: show" {
    DEBUG= run _stacktrace
    assert_output ""
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
