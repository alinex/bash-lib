#!/usr/bin/env bats
# shellcheck disable=SC2154

# bats file_tags=compress
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# compress
######################################################################################

# bats test_tags=compress
@test "compress: with default tool" {
    run bats_pipe compress 123 \| decompress
    assert_output 123
    assert_success
}
# bats test_tags=compress
@test "compress: with gzip tool" {
    run bats_pipe compress --tool=gzip 123 \| decompress --tool=gzip
    assert_output 123
    assert_success
}
# bats test_tags=compress
@test "compress: with bzip2 tool" {
    run bats_pipe compress --tool=bzip2 123 \| decompress --tool=bzip2
    assert_output 123
    assert_success
}
# bats test_tags=compress
@test "compress: with xz tool" {
    run bats_pipe compress --tool=xz 123 \| decompress --tool=xz
    assert_output 123
    assert_success
}
# bats test_tags=compress
@test "compress: with zstd tool" {
    run bats_pipe compress --tool=zstd 123 \| decompress --tool=zstd
    assert_output 123
    assert_success
}
# bats test_tags=compress
@test "compress: with lz4 tool" {
    run bats_pipe compress --tool=lz4 123 \| decompress --tool=lz4
    assert_output 123
    assert_success
}
