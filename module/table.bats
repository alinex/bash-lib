#!/usr/bin/env bats

# bats file_tags=table
setup() {
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
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

# bats test_tags=tsv,tsv-headers
@test "tsv: remove header" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv headers --remove
    assert_output -p $'1,2\t3'
    assert_success
}
# bats test_tags=tsv,tsv-headers
@test "tsv: show header" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv headers
    assert_output -p $'col1\ncol2'
    assert_success
}

# bats test_tags=tsv,tsv-count
@test "tsv: count records" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv count
    assert_output 1
    assert_success
}
# bats test_tags=tsv,tsv-count
@test "tsv: count records without headers" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv count --no-headers
    assert_output 2
    assert_success
}

# bats test_tags=tsv,tsv-select
@test "tsv: select columns" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv select 1
    assert_output -p $'col1\n1,2'
    assert_success
}

# ---------------------------------------

# bats test_tags=tsv
@test "tsv: filter string" {
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
EOT
)"
    run bats_pipe echo "$in" \| tsv --with-header filter string 2 '=*' 'f*'
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv
@test "tsv: filter string (named column)" {
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
EOT
)"
    run bats_pipe echo "$in" \| tsv --with-header filter string col2 '=*' 'f*'
    assert_output "$out"
    assert_success
}

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
number1	a very long line with text which should be cropped
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
number1	a very long line with text which should be cropped
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
@test "tsv: sort col1 (with header)" {
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
    run bats_pipe echo "$in" \| tsv --with-header sort col1
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
10	ten
4	four
5	five
col1	col2
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
10	ten
5	five
4	four
col1	col2
EOT
)"
    run bats_pipe echo "$in" \| tsv reverse
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv
@test "tsv: reverse (with header)" {
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
    run bats_pipe echo "$in" \| tsv --with-header reverse
    assert_output "$out"
    assert_success
}
