#!/bin/bash

# Library for colorized output
#
# https://gitlab.ekz.de/divibib-betrieb/helper-lib/blob/master/doc/info.md
#
# Usage:
#
# source ../bash-lib/include/info.bash  # load methods
# data=$(info_debian)

source_dir=$(dirname "${BASH_SOURCE[0]}")
source "$source_dir/log.bash" # load log handler

# output debian type like stretch/sid
info_debian() {
  file=/etc/debian_version
  [ -f $file ] || return 1
  case $(cat $file) in
  7*|wheezy*) echo 7;;
  8*|jessie*) echo 8;;
  9*|stretch*) echo 9;;
  1ß*|buster*) echo 10;;
  11*|bullseye*) echo 11;;
  12*|bookworm*) echo 12;;
  *) cat $file;;
  esac
}

# usage: info_package <name>
# output: version number
info_package() {
  [ "$#" -ne 1 ] && log_exit ALERT "parameter missing call: info_package <name>"

  data=$(dpkg -s $1 2>/dev/null)
  [ $? -eq 0 ] || return 1
  echo $data | grep Version | sed "s/Version: //"
  return 0
}