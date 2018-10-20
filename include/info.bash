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

os_type() {
  if [ -f /etc/debian_version ]; then
    echo debian
  fi
}

# output debian major number
os() {
  type=$(os_type)
  case $type in
  debian)
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
    ;;
  *)
    log_exit ALERT "unknown operating system $type not supported"
    ;;
  esac
}

# usage: info_package <name>
# output: version number
package() {
  [ "$#" -ne 1 ] && log_exit ALERT "parameter missing call: info_package <name>"

  type=$(os_type)
  case $type in
  debian)
    data=$(dpkg -s $1 2>/dev/null)
    [ $? -eq 0 ] || return 1
    echo $data | grep Version | sed "s/Version: //"
    return 0
    ;;
  *)
    log_exit ALERT "unknown operating system $type not supported"
    ;;
  esac
}
