#!/bin/bash

# Library for colorized output
#
# https://gitlab.ekz.de/divibib-betrieb/helper-lib/blob/master/doc/colors.md
#
# Usage:
#
# source ../bash-lib/include/colors.bash  # load color methods
# red "Failed"
# echo "$(red)Failed$(reset)"
# echo "$(red Failed)"

term=${TERM:-xterm-256color} # use xterm as default if no terminal set

# Helper
_color_text() {
    [ -z "$1" ] && return
    echo -n "$1"
    tput -T$term sgr0;
}

# Foreground color
black() { tput -T$term setaf 0; _color_text "$@"; }
red() { tput -T$term setaf 1; _color_text "$@"; }
green() { tput -T$term setaf 2; _color_text "$@"; }
yellow() { tput -T$term setaf 3; _color_text "$@"; }
blue() { tput -T$term setaf 4; _color_text "$@"; }
magenta() { tput -T$term setaf 5; _color_text "$@"; }
cyan() { tput -T$term setaf 6; _color_text "$@"; }
white() { tput -T$term setaf 7; _color_text "$@"; }

# Background color
bg_black() { tput -T$term setab 0; _color_text "$@"; }
bg_red() { tput -T$term setab 1; _color_text "$@"; }
bg_green() { tput -T$term setab 2; _color_text "$@"; }
bg_yellow() { tput -T$term setab 3; _color_text "$@"; }
bg_blue() { tput -T$term setab 4; _color_text "$@"; }
bg_magenta() { tput -T$term setab 5; _color_text "$@"; }
bg_cyan() { tput -T$term setab 6; _color_text "$@"; }
bg_white() { tput -T$term setab 7; _color_text "$@"; }

# Styles
bold() { tput -T$term bold; _color_text "$@"; }
underline() { tput -T$term smul; _color_text "$@"; }
inverse() { tput -T$term rev; _color_text "$@"; }
dim() { tput -T$term dim; _color_text "$@"; }

# Reset
reset() { tput -T$term sgr0; }
