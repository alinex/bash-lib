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
# bats test_tags=tsv
@test "tsv: to pprint" {
    in="$(cat <<'EOT'
col1	col2
1,2	3
EOT
)"
    out="$(cat <<'EOT'
col1  col2
1,2   3
EOT
)"
    run bats_pipe echo "$in" \| tsv to pprint
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv
@test "tsv: crop 2 10" {
    in="$(cat <<'EOT'
col1	col2
number1	a very long line with text which shoould be cropped
EOT
)"
    out="$(cat <<'EOT'
col1	col2
number1	a very lo…
EOT
)"
    run bats_pipe echo "$in" \| tsv crop 2 10
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv
@test "tsv: crop col2 10" {
    in="$(cat <<'EOT'
col1	col2
number1	a very long line with text which shoould be cropped
EOT
)"
    out="$(cat <<'EOT'
col1	col2
number1	a very lo…
EOT
)"
    run bats_pipe echo "$in" \| tsv crop col2 10
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv
@test "tsv: sort 2" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
5	five
4	four
10	ten
EOT
)"
    run bats_pipe echo "$in" \| tsv sort 2
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv
@test "tsv: sort col1" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
10	ten
4	four
5	five
EOT
)"
    run bats_pipe echo "$in" \| tsv sort col1
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv
@test "tsv: sort col1 numeric" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    run bats_pipe echo "$in" \| tsv sort col1 numeric
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv
@test "tsv: reverse" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
10	ten
5	five
4	four
EOT
)"
    run bats_pipe echo "$in" \| tsv reverse
    assert_output "$out"
    assert_success
}