#!/usr/bin/env bats

# bats file_tags=table
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# tsv2table
######################################################################################

# bats test_tags=tsv2table
@test "tsv2table: with message as argument" {
    run tsv2table $'col1\tcol2\n1\tone'
    assert_success
    assert_output -p $'col1 col2\n1    one'
}
# bats test_tags=tsv2table
@test "tsv2table: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2table
    assert_success
    assert_output -p $'col1 col2\n1    one'
}

######################################################################################
# tsv2md
######################################################################################

# bats test_tags=tsv2md
@test "tsv2md: with message as argument" {
    run tsv2md $'col1\tcol2\n1\tone'
    assert_output -p $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
}
# bats test_tags=tsv2md
@test "tsv2md: with piped message" {
    run bats_pipe echo $'col1\tcol2\n1\tone' \| tsv2md
    assert_output -p $'| col1 | col2 |\n| --- | --- |\n| 1 | one |'
    assert_success
}

######################################################################################
# csv
######################################################################################

# bats test_tags=csv
@test "csv: to tsv" {
    run bats_pipe echo $'col1,col2\n"1,2",3' \| csv to tsv
    assert_output -p $'col1\tcol2\n1,2\t3'
    assert_success
}

######################################################################################
# tsv
######################################################################################

# bats test_tags=tsv
@test "tsv: to csv" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv to csv
    assert_output -p $'col1,col2\n"1,2",3'
    assert_success
}
