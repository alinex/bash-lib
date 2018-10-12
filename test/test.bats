@test "red text should be there" {
  load "../include/colors"
  run red test
  [[ "$output" =~ "test" ]]
}
