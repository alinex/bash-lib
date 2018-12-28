# System Information

This is a collection of methods to gain system information.

## Base Information

The general information is stored within variables on load:

- `OS` - type of OS like: Linux, windows, mac, Solaris, AIX
- `KERNEL` - version number like: 4.4.0-135-generic
- `MACH` - machine type like: x86_64
- `DIST_BASE` - distribution (for Linux): RedHat, SuSe, Mandrake, Debian
- `DIST` - distribution like: LinuxMint, Ubuntu
- `REV` - revision number of distribution
- `REV_NAME` - code name of this revision

> You can use these directly!

But to get them all combined in a human readable line call:

```bash
info=$(system_info)
echo $info # Linux system with kernel 4.15.0-38-generic x86_64 (neon 18.04 bionic based on Debian)
```

## Packages

With `package` you may check if a specific package is installed and get the version from it.

```bash
tomcat=$(package tomcat) || log WARN "No tomcat installed!"
echo $tomcat # will output 8
```

As seen above you can also use shortcuts which don't completely equal to the package name because it will be extended automatically as far as this is predefined in code.
