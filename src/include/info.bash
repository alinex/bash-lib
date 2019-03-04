#!/bin/bash

# Library for colorized output
#
# https://gitlab.com/alinex/bash-lib/blob/master/doc/log.md
#
# Usage:
#
# source ../bash-lib/include/info.bash  # load methods

#[ -n "$OS" ] && return 0 # library already loaded

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
        if [ -f /etc/arch-release ] ; then
            DIST_BASE='ArchLinux'
            DIST='ArchLinux'
            REV_NAME="Rolling"
            REV=$(grep base /var/log/pacman.log | tail -n 1)
        elif [ -f /etc/gentoo-release ] ; then
            DIST_BASE='Gentoo'
            DIST=$(cat /etc/gentoo-release | sed s/\ release.*//)
            REV=$(cat /etc/gentoo-release | sed s/.*release\ // | sed s/\ .*//)
        elif [ -f /etc/redhat-release ] ; then
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

# Extended hardware analyzation
hw_machine_id() {
    cat /etc/machine-id /var/lib/dbus/machine-id /var/db/dbus/machine-id /sys/class/dmi/id/board_serial 2>/dev/null | head -n 1
}
hw_virtual() {
    grep -q '^flags.* hypervisor' /proc/cpuinfo && echo "true"
    exit 0
}
hw_cores() { grep -c ^processor /proc/cpuinfo; }
hw_processor() { grep 'model name' /proc/cpuinfo | head -n 1 | sed 's/^.*: //'; }
hw_memory_mb() {
    #free -m | grep -oP '\d+' | head -n 1
    expr $(grep MemTotal /proc/meminfo | awk '{print $2}') / 1024
}
hw_swap_mb() {
    #free -m | tail -n 1 | grep -oP '\d+' | head -n 1
    expr $(grep SwapTotal /proc/meminfo | awk '{print $2}') / 1024
}
# return size, usage, mount
hw_disks() {
    df -lBG | grep ^/dev/ | awk '{print $2, $5, $6}'
}

# ip analyzation
ip_main() {
    command -v ip > /dev/null
    if [ $? -eq 0 ]; then
        ip route get 1 | sed -e 's/ uid.*//' | awk '{print $NF;exit}'
    else
        ifconfig | egrep 'inet |inet6 ' | egrep -v ' ::1|127.0.0.1' | awk '{print $2}' | head -n 1
    fi
}
ip_list() {
    command -v ip > /dev/null
    if [ $? -eq 0 ]; then
        ip address | grep global | awk '{ print $2 }' | sed -e 's/\/.*//'
    else
        ifconfig | egrep 'inet |inet6 ' | egrep -v ' ::1|127.0.0.1' | awk '{print $2}'
    fi
}

# return:
# ip 46.237.195.215
# hostname HSI-KBW-46-237-195-215.hsi.kabel-badenwuerttemberg.de
# city Dornhan
# region Baden-Württemberg Region
# country DE
# loc 48.3501,8.5090
# postal 72175
# org AS29562 Unitymedia BW GmbH
ip_info() {
    if [ -z "$_ip_info" ]; then
        _ip_info=$(curl -s ipinfo.io | tr '\n' ' ' | sed -e 's/[{}]/''/g;s/",/"\n/g;s/ *"//g;s/:/ /g' | awk 'NF')
    fi
    echo "$_ip_info"
}

# Software analyzation

# lookup for real names
declare -A _package
_package[apache]="apache2"
_package[tomcat]="tomcat8 tomcat7 tomcat6"
_package[jdk]="openjdk-11-jdk openjdk-10-jdk openjdk-9-jdk openjdk-8-jdk openjdk-7-jdk openjdk-6-jdk"
_package[jre]="openjdk-11-jre openjdk-10-jre openjdk-9-jre openjdk-8-jre openjdk-7-jre openjdk-6-jre"
_package[postgresql]="postgresql-11 postgresql-10 postgresql-9.6 postgresql-9.4 postgresql-9.3"
declare -r _package

# Usage: package <name>
# Output: name section package version
package() {
    [ "$#" -ne 1 ] && log_exit ALERT "parameter missing. Usage: package <name>"
    unset IFS # in case it is not the default
    search=$1
    return=1
    case $DIST_BASE in
    Debian)
        alt=${_package[$search]}
        if [ -n "$alt" ]; then
            for check in $alt
            do
                # check package
                local found=$(dpkg -s $check 2>/dev/null)
                if [[ $found =~ ok.installed ]]; then
                    package=$(echo -e "$found" | grep Package | awk '{print $2}')
                    section=$(echo -e "$found" | grep Section | awk '{print $2}')
                    version=$(echo -e "$found" | grep Version | awk '{print $2}')
                    log DEBUG "$search is installed with package $package version $version"
                    echo $search $section $package $version
                    return=0
                fi
            done
        else
            local found=$(dpkg -s $search 2>/dev/null)
            if [[ $found =~ ok.installed ]]; then
                package=$(echo -e "$found" | grep Package | awk '{print $2}')
                section=$(echo -e "$found" | grep Section | awk '{print $2}')
                version=$(echo -e "$found" | grep Version | awk '{print $2}')
                log DEBUG "$search is installed with package $package version $version"
                echo $search $section $package $version
                return=0
            fi
        fi
        return $return
        ;;
    *)
        log_exit ALERT "operating system not supported: $(system_info)"
        ;;
    esac
}
# output: <package name> <version>
package_list() {
    for p in "${!_package[@]}"; do
        package $p
    done
}

# setup information

# output: <account> <name> <type> <key>
ssh_keys() {
    for user in $(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd); do
        ssh=$(cat /home/$user/.ssh/authorized_keys /home/$user/.ssh/authorized_keys2 2>/dev/null)
        if [ -n "$ssh" ]; then
            echo "$ssh" | grep ssh- \
            | sed 's/:.*SSHAUTH_USERNAME=\\"\([0-9]* - \)\?\([^ ]*\).* \(ssh-.*\)/ \3 \2/;s/^[a-z/]*\/\([a-z]*\)\/.ssh.* /\1 /;s/ $//' \
            | awk 'NF' | awk '{ print $3 " " $1 " " $2}' \
            | sed "s/^/$user /" | sort | uniq
        fi
    done
}

# output: <where> <minute> <hour> <day> <month> <wday> <user> <command>
strings='s/^@yearly/0 0 1 1 \*/;s/^@annually/0 0 1 1 \*/;s/^@monthly/0 0 1 \* \*/;s/^@weekly/0 0 \* \* 0/;s/^@daily/0 0 \* \* \*/
s/^@midnight/0 0 \* \* \*/;s/^@hourly/0 \* \* \* \*/;/^[a-zA-Z]*=/d'
cron_tasks() {
    if [ $(id -u) -ne 0 ]; then
        log WARN "Could only read cron entries from the connecting user: $(whoami)"
        crontab -l | sed "$strings;s/#.*//g" | awk 'NF' \
        | while read min hour day month week cmd; do
            echo "user $min $hour $day $month $week $(whoami) $cmd"
        done
    else
        ls /var/spool/cron/crontabs \
        | while read user; do
            cat /var/spool/cron/crontabs/$user | sed "$strings;s/#.*//g" | awk 'NF' \
            | while read min hour day month week cmd; do
                echo "user $min $hour $day $month $week $user $cmd"
            done
        done
    fi

    cat /etc/cron.d/* | sed "$strings;s/#.*//g" | awk 'NF' | sed "s/^/cron.d /"

    periods=(daily weekly monthly)
    for period in $periods; do
        grep /etc/cron.period /etc/crontab | head -n 1 \
        | while read min hour day month week cmd; do
            ls -1 /etc/cron.period | sed "s/^/period $min $hour $day $month $week root /"
        done
    done
}
#https://manpages.debian.org/testing/cron/crontab.5.en.html

# middleware
# output: <package> <middleware> <setting> <value>
#         tomcat     tomcat8_1   uri http://:8080

# app
# output: <package> <middleware> <app> <version> <setting> <value>
#         tomcat        tomcat8_1 xxx    1.0.1  uri http://:8080/context  
#         tomcat        tomcat8_1 xxx    1.0.1  threads 500 
