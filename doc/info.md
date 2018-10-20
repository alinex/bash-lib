# System Information

This is a collection of methods to gain system information.

## Operating System

Two methods may be used to detect the operating system.

### os_type

This method is called without parameters and will return the basename of the operating system.
For Ubuntu, LinuxMint this is `debian`.

```bash
type=$(os_type)
```

### os_version

Additionaly to the OS type this will give you the major number of the operating system.

```bash
version=$(os_version)
```

## Packages

With `package` you may check if a specific package is installed and get the version from it.

```bash
tomcat=$(package tomcat)
echo $tomcat # will output 8
```

As seen above you can also use shortcuts which don't completely equal to the package name because it will be extended automatically.
