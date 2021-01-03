# System Information

This is a collection of methods to gain system information.

## Base Information

The general information is stored within variables on load:

-   `OS` - type of OS like: Linux, windows, mac, Solaris, AIX
-   `KERNEL` - version number like: 4.4.0-135-generic
-   `MACH` - machine type like: x86_64
-   `DIST_BASE` - base distribution (for Linux): RedHat, SuSe, Mandrake, Debian
-   `DIST_BASE_REV` - base distribution number or name (if possible)
-   `DIST` - distribution like: LinuxMint, Ubuntu
-   `REV` - revision number of distribution
-   `REV_NAME` - code name of this revision

> You can use these directly!

But to get them all combined in a human readable line call:

```bash
info=$(system_info)
echo $info # Linux system with kernel 4.15.0-38-generic x86_64 (neon 18.04 bionic based on Debian)
```

## Extended System Info

This information is reachable with some parameter less function calls.

### hw_machine_id

Unique ID for the hardware machine if defined.

### hw_virtual

Returns `true` if this is a virtual machine.

### hw_cores

Returns the number of cpu cores available.

### hw_cores

Returns the number of cpu cores available.

### hw_load

Returns the short load of the system.

### hw_processor

Returns the processor model name which may include some technical specifications.

### hw_memory_mb

Returns the memory size in MB.

### hw_free_mb

Returns the free memory size in MB.

### hw_avail_mb

Returns the available memory, which is available for processes. This may be occupied by caching at the moment.

### hw_swap_mb

Returns the swap size in MB.

### hw_swap_free_mb

Returns the free swap size in MB.

### hw_disks

Returns a list of disks with size, usage (percentage) and mount point.

### ip_main

Returns the main IP address.

### ip_list

Returns all listening IP addresses.

### ip_info

Retrieves some geo location information from the IP the system uses to enter the public internet like:

    ip 46.237.195.215
    hostname HSI-KBW-46-237-195-215.hsi.kabel-badenwuerttemberg.de
    city Dornhan
    region Baden-Württemberg Region
    country DE
    loc 48.3501,8.5090
    postal 72175
    org AS29562 Unitymedia BW GmbH

## Packages

### package

With `package` you may check if a specific package is installed and get the version from it.

```bash
tomcat=$(package tomcat) || log WARN "No tomcat installed!"
echo $tomcat # will output 8
```

As seen above you can also use shortcuts which don't completely equal to the package name because it will be extended automatically as far as this is predefined in code.

### package_list

You can also check which of the special systems (hard coded list) are installed.
It will return: `<package name> <version>`

## Configuration

### ssh_keys

If called this script will generate a list of all allowed ssh-key based users with: `<account> <name> <type> <key>`

### sudoers

This will create a list with all users on the system and what they are allowed to call using sudo: `<account> <sudo-rights>`

### cron_tasks

This will go through:

-   user crontabs
-   cron.d scripts
-   hourly, daily, weekly, monthly tasks

All found entries will be combined into the following format: `<where> <minute> <hour> <day> <month> <wday> <user> <command>`.

{!docs/assets/abbreviations.txt!}
