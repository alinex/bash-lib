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
@test "tsv: select column" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv select 1
    assert_output -p $'col1\n1,2'
    assert_success
}
# bats test_tags=tsv,tsv-select
@test "tsv: select column by name" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv select col2
    assert_output -p $'col2\n3'
    assert_success
}
# bats test_tags=tsv,tsv-select
@test "tsv: negative select with sort" {
    run bats_pipe echo $'col2\tcol1\tcol3\n1,2\t3\t99' \| tsv select '!col3' --sort
    assert_output -p $'col1\tcol2\n3\t1,2'
    assert_success
}

# bats test_tags=tsv-filter
@test "tsv: filter pattern" {
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
    run bats_pipe echo "$in" \| tsv filter 'f.*' 2
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-filter
@test "tsv: filter exact match" {
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
EOT
)"
    run bats_pipe echo "$in" \| tsv filter --exact four
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-filter
@test "tsv: filter invert match" {
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
10	ten
EOT
)"
    run bats_pipe echo "$in" \| tsv filter --exact four --invert
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-filter
@test "tsv: filter flag" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2	ok
4	four	1
5	five	2
10	ten	0
EOT
)"
    run bats_pipe echo "$in" \| tsv filter --flag=ok 'f.*' 2
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-slice
@test "tsv: get slice" {
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
    run bats_pipe echo "$in" \| tsv slice 0 2
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-slice
@test "tsv: invert slice" {
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
EOT
)"
    run bats_pipe echo "$in" \| tsv slice 0 2 --invert
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-sort
@test "tsv: sort" {
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
    run bats_pipe echo "$in" \| tsv sort
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-sort
@test "tsv: sort numeric" {
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
    run bats_pipe echo "$in" \| tsv sort --numeric
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-sort
@test "tsv: sort unique" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
4	vier
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
    run bats_pipe echo "$in" \| tsv sort --numeric 1 --unique
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-sort
@test "tsv: reverse sort" {
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
    run bats_pipe echo "$in" \| tsv sort --reverse col2
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-reverse
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

# bats test_tags=tsv-edit
@test "tsv: edit" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
3	four
5	five
10	ten
EOT
)"
    run bats_pipe echo "$in" \| tsv edit 0 0 3
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-crop
@test "tsv: crop" {
    in="$(cat <<'EOT'
col1	col2
4	fourthousand
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1	col2
4	four…
5	five
10	ten
EOT
)"
    run bats_pipe echo "$in" \| tsv crop col2 5
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-print
@test "tsv: print" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
col1  col2
4     four
5     five
10    ten
EOT
)"
    run bats_pipe echo "$in" \| tsv print
    assert_output "$out"
    assert_success
}

# bats test_tags=tsv-to
@test "tsv: to csv" {
    run bats_pipe echo $'col1\tcol2\n1,2\t3' \| tsv to csv
    assert_output -p $'col1,col2\n"1,2",3'
    assert_success
}
# bats test_tags=tsv-to
@test "tsv: to json" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
{"col1":4,"col2":"four"}
{"col1":5,"col2":"five"}
{"col1":10,"col2":"ten"}
EOT
)"
    run bats_pipe echo "$in" \| tsv to json
    assert_output "$out"
    assert_success
}
# bats test_tags=tsv-to
@test "tsv: to postgres" {
    in="$(cat <<'EOT'
col1	col2
4	four
5	five
10	ten
EOT
)"
    out="$(cat <<'EOT'
CREATE TABLE IF NOT EXISTS "data" ( "col1" BIGINT 
 , "col2" TEXT 
);
EOT
)"
    run bats_pipe echo "$in" \| tsv to postgres --table=data
    assert_output -p "$out"
    assert_success
}
