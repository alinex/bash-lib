#!/bin/bash

# Library for colorized output
#
# https://gitlab.ekz.de/divibib-betrieb/helper-lib/blob/master/doc/info.md
#
# Usage:
#
# source ../bash-lib/include/info.bash  # load methods
# data=$(info_debian)

#[ -n "$_log_level[DEBUG]" ] && return 0 # library already loaded

source_dir=$(dirname "${BASH_SOURCE[0]}")
source "$source_dir/log.bash" # load log handler

# Output: base os type
os_type() {
  if [ -f /etc/debian_version ]; then
    echo debian
  fi
}

# Output: debian major number
os_version() {
  local type=$(os_type)
  case $type in
  debian)
    local file=/etc/debian_version
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

# lookup for real names
declare -A _package_debian
_package_debian[apache]="apache2"
_package_debian[tomcat]="tomcat7 tomcat8"
_package_debian[jdk]="openjdk-11-jdk openjdk-10-jdk openjdk-9-jdk openjdk-8-jdk openjdk-7-jdk openjdk-6-jdk"
_package_debian[jre]="openjdk-11-jre openjdk-10-jre openjdk-9-jre openjdk-8-jre openjdk-7-jre openjdk-6-jre"
_package_debian[postgresql]="postgresql-10 postgresql-9.6 postgresql-9.4 postgresql-9.3"
#declare -r _package_debian

# Usage: info_package <name>
# Output: version number
package() {
  [ "$#" -ne 1 ] && log_exit ALERT "parameter missing. Usage: info_package <name>"

  local type=$(os_type)
  case $type in
  debian)
    alt=${_package_debian[$1]}
    if [ -n "$alt" ]; then
      for check in $alt
      do
        # check package
        local found=$(dpkg -s $check 2>/dev/null)
        if [ -n "$found" ]; then
          echo -e "$found" | grep Version | sed "s/Version: //"
          return 0
        fi
      done
    else
      local found=$(dpkg -s $1 2>/dev/null)
      [ $? -eq 0 ] || return 1
      echo -e "$found" | grep Version | sed "s/Version: //"
      return 0
    fi
    return 1
    ;;
  *)
    log_exit ALERT "unknown operating system $type not supported"
    ;;
  esac
}
