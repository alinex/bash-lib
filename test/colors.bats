@test "output black text directly" {
  load "../include/colors"
  run black text
  [ $status ]
  echo "black text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output black text with builder" {
  load "../include/colors"
  run echo "$(black)text$(reset)"
  [ $status ]
  echo "black text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output red text directly" {
  load "../include/colors"
  run red text
  [ $status ]
  echo "red text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output red text with builder" {
  load "../include/colors"
  run echo "$(red)text$(reset)"
  [ $status ]
  echo "red text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output green text directly" {
  load "../include/colors"
  run green text
  [ $status ]
  echo "green text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output green text with builder" {
  load "../include/colors"
  run echo "$(green)text$(reset)"
  [ $status ]
  echo "green text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output yellow text directly" {
  load "../include/colors"
  run yellow text
  [ $status ]
  echo "yellow text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output yellow text with builder" {
  load "../include/colors"
  run echo "$(yellow)text$(reset)"
  [ $status ]
  echo "yellow text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output blue text directly" {
  load "../include/colors"
  run blue text
  [ $status ]
  echo "blue text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output blue text with builder" {
  load "../include/colors"
  run echo "$(blue)text$(reset)"
  [ $status ]
  echo "blue text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output magenta text directly" {
  load "../include/colors"
  run magenta text
  [ $status ]
  echo "magenta text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output magenta text with builder" {
  load "../include/colors"
  run echo "$(magenta)text$(reset)"
  [ $status ]
  echo "magenta text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output cyan text directly" {
  load "../include/colors"
  run cyan text
  [ $status ]
  echo "cyan text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output cyan text with builder" {
  load "../include/colors"
  run echo "$(cyan)text$(reset)"
  [ $status ]
  echo "cyan text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output white text directly" {
  load "../include/colors"
  run white text
  [ $status ]
  echo "white text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output white text with builder" {
  load "../include/colors"
  run echo "$(white)text$(reset)"
  [ $status ]
  echo "white text: $output" >&3
  [[ "$output" =~ "text" ]]
}

# background colors

@test "output bg_black text directly" {
  load "../include/colors"
  run bg_black text
  [ $status ]
  echo "bg_black text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_black text with builder" {
  load "../include/colors"
  run echo "$(bg_black)text$(reset)"
  [ $status ]
  echo "bg_black text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_red text directly" {
  load "../include/colors"
  run bg_red text
  [ $status ]
  echo "bg_red text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_red text with builder" {
  load "../include/colors"
  run echo "$(bg_red)text$(reset)"
  [ $status ]
  echo "bg_red text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_green text directly" {
  load "../include/colors"
  run bg_green text
  [ $status ]
  echo "bg_green text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_green text with builder" {
  load "../include/colors"
  run echo "$(bg_green)text$(reset)"
  [ $status ]
  echo "bg_green text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_yellow text directly" {
  load "../include/colors"
  run bg_yellow text
  [ $status ]
  echo "bg_yellow text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_yellow text with builder" {
  load "../include/colors"
  run echo "$(bg_yellow)text$(reset)"
  [ $status ]
  echo "bg_yellow text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_blue text directly" {
  load "../include/colors"
  run bg_blue text
  [ $status ]
  echo "bg_blue text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_blue text with builder" {
  load "../include/colors"
  run echo "$(bg_blue)text$(reset)"
  [ $status ]
  echo "bg_blue text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_magenta text directly" {
  load "../include/colors"
  run bg_magenta text
  [ $status ]
  echo "bg_magenta text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_magenta text with builder" {
  load "../include/colors"
  run echo "$(bg_magenta)text$(reset)"
  [ $status ]
  echo "bg_magenta text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_cyan text directly" {
  load "../include/colors"
  run bg_cyan text
  [ $status ]
  echo "bg_cyan text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_cyan text with builder" {
  load "../include/colors"
  run echo "$(bg_cyan)text$(reset)"
  [ $status ]
  echo "bg_cyan text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output bg_white text directly" {
  load "../include/colors"
  run bg_white text
  [ $status ]
  echo "bg_white text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bg_white text with builder" {
  load "../include/colors"
  run echo "$(bg_white)text$(reset)"
  [ $status ]
  echo "bg_white text: $output" >&3
  [[ "$output" =~ "text" ]]
}

# Styles

@test "output bold text directly" {
  load "../include/colors"
  run bold text
  [ $status ]
  echo "bold text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output bold text with builder" {
  load "../include/colors"
  run echo "$(bold)text$(reset)"
  [ $status ]
  echo "bold text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output underline text directly" {
  load "../include/colors"
  run underline text
  [ $status ]
  echo "underline text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output underline text with builder" {
  load "../include/colors"
  run echo "$(underline)text$(reset)"
  [ $status ]
  echo "underline text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output inverse text directly" {
  load "../include/colors"
  run inverse text
  [ $status ]
  echo "inverse text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output inverse text with builder" {
  load "../include/colors"
  run echo "$(inverse)text$(reset)"
  [ $status ]
  echo "inverse text: $output" >&3
  [[ "$output" =~ "text" ]]
}

@test "output dim text directly" {
  load "../include/colors"
  run dim text
  [ $status ]
  echo "dim text: $output" >&3
  [[ "$output" =~ "text" ]]
}
@test "output dim text with builder" {
  load "../include/colors"
  run echo "$(dim)text$(reset)"
  [ $status ]
  echo "dim text: $output" >&3
  [[ "$output" =~ "text" ]]
}

# combined

@test "mixed colors and styles" {
  load "../include/colors"
  run echo "This $(red)text $(bold)fails$(reset) sometimes"
  [ $status ]
  echo "mixed text: $output" >&3
  [[ "$output" =~ "text" ]]
}
