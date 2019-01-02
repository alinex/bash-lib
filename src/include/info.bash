#!/bin/bash

# Library for colorized output
#
# https://gitlab.com/alinex/bash-lib/blob/master/doc/log.md
#
# Usage:
#
# source ../bash-lib/include/info.bash  # load methods
# data=$(info_debian)

[ -n "$OS" ] && return 0 # library already loaded

source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/log.bash" # load log handler

# start basic analyzation
OS=$(uname | tr '[:upper:]' '[:lower:]')
KERNEL=$(uname -r)
MACH=$(uname -m)

if [ "{$OS}" == "windowsnt" ]; then
    OS=Windows
elif [ "{$OS}" == "darwin" ]; then
    OS=Mac
else
    OS=$(uname)
    if [ "${OS}" = "SunOS" ] ; then
        OS=Solaris
        MACH=$(uname -p)
        #OS_STRING="${OS} ${REV}(${ARCH} $(uname -v))"
    #elif [ "${OS}" = "AIX" ] ; then
        #OS_STRING="${OS} $(oslevel) ($(oslevel -r))"
    elif [ "${OS}" = "Linux" ] ; then
        if [ -f /etc/redhat-release ] ; then
            DIST_BASE='RedHat'
            DIST=$(cat /etc/redhat-release | sed s/\ release.*//)
            REV_NAME=$(cat /etc/redhat-release | sed s/.*\(// | sed s/\)//)
            REV=$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)
        elif [ -f /etc/SuSE-release ] ; then
            DIST_BASE='SuSe'
            REV_NAME=$(cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//)
            REV=$(cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //)
        elif [ -f /etc/mandrake-release ] ; then
            DIST_BASE='Mandrake'
            REV_NAME=$(cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//)
            REV=$(cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//)
        elif [ -f /etc/debian_version ] ; then
            DIST_BASE='Debian'
            DIST_BASE_REV=$(cat /etc/debian_version | sed -e 's/\([0-9]*\)\..*/\1/')
            DIST=$(grep '^DISTRIB_ID=' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
            [ -z "$DIST" ] && DIST=$(grep '^NAME=' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }' | sed 's/"//g')
            REV_NAME=$(grep '^DISTRIB_CODENAME=' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
            [ -z "$REV_NAME" ] && REV_NAME=$(grep '^VERSION=' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }' | sed 's/^.*(\(.*\)).*/\1/g')
            REV=$(grep '^DISTRIB_RELEASE=' /etc/lsb-release /etc/os-release 2>/dev/null | head -n 1 | awk -F=  '{ print $2 }')
            [ -z "$REV" ] && REV=$(cat /etc/debian_version)
        fi
        if [ -f /etc/UnitedLinux-release ] ; then
            DIST="${DIST}[$(cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//)]"
        fi
        declare -r OS
        declare -r KERNEL
        declare -r MACH
        declare -r DIST
        declare -r DIST_BASE
        declare -r DIST_BASE_REV
        declare -r REV_NAME
        declare -r REV
    fi
fi

# Output: human readable system information line
system_info() {
  local dist_base
  local rev
  [ -n "$DIST_BASE" ] && dist_base="based on $DIST_BASE $DIST_BASE_REV"
  [ -n "$REV" ] && rev="$REV $REV_NAME"
  echo "$OS system with kernel $KERNEL $MACH ($(echo $DIST $rev $dist_base))"
}

hw_cores() { grep -c ^processor /proc/cpuinfo; }
hw_processor() { grep 'model name' /proc/cpuinfo | head -n 1 | sed 's/^.*: //'; }
hw_memory_mb() { free -m | grep -oP '\d+' | head -n 1; }
# return size, usage, mount
hw_disks() {
    df -lBG | grep ^/dev/ | awk '{print $2, $5, $6}'
}

ip_main() { ip route get 1 | awk '{print $NF;exit}'; }
ip_list() { LANG=C /sbin/ifconfig | grep inet | egrep -v "127.0.0.1|::1/128" | sed 's/: /:/;s/^.*addr:\(.*\)/\1/;s/ .*$//'; }

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
    unset IFS # in case it is not the default

    case $DIST_BASE in
    Debian)
        alt=${_package_debian[$1]}
        if [ -n "$alt" ]; then
            for check in $alt
            do
                # check package
                local found=$(dpkg -s $check 2>/dev/null)
                if [ -n "$found" ]; then
                    result=$(echo -e "$found" | grep Version | sed "s/Version: //")
                    log DEBUG "package $1 is installed with version $result"
                    echo $result
                return 0
                fi
            done
        else
            local found=$(dpkg -s $1 2>/dev/null)
            [ $? -eq 0 ] || return 1
            result=$(echo -e "$found" | grep Version | sed "s/Version: //")
            log DEBUG "package $1 is installed with version $result"
            echo $result
            return 0
        fi
        return 1
        ;;
    *)
        log_exit ALERT "operating system not supported: $(system_info)"
        ;;
    esac
}
