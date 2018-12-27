title: Usage

# Bash Library

This is a collection of helper programs and libraries for administration tool development (mostly in bash). The complete library is build into combined packages, which mostly can be added as single include file to work. 

This documentation will show you how to use them.

## Installation

Mostly you won't install the bash-lib on a server but create some scripts based on it. But that won't mean you can't or you shouldn't do so. As always it depends on your needs.

> See the following chapter for all the possibilities to use it. 

First copy the full distribution package or only the parts you need standalone or within your application onto a server ...

#But if you want to install it, you need to copy the whole distribution package onto a server.
#
#To use them on a machine, copy the `dist` folder to a central position and use it from there. #This will often be in `/opt` or `/opt/divibib/` and also included in the path:
#
#    cp dist /opt/bash-lib
#    echo "PATH=\"$PATH:/opt/bash-lib\"" >> ~/.bashrc
#
#But you can also always copy the command directly to any other folder and use it from there.

Check the server requirements by calling:



### Build

First of all, if you have this source repository checked out on your machine you need to run the build script under `bin/build` to create the distribution folder `dist`. This folder will hold the files you may use.

The `dist` folder contains the combined libraries, described below:

        -rw-rw-r-- 1 alex alex  9994 Nov  9 08:11 base.bash
        -rw-rw-r-- 1 alex alex 10970 Nov  9 08:11 psql.bash
        -rw-rw-r-- 1 alex alex 11603 Nov  9 08:11 locking.bash
        -rw-rw-r-- 1 alex alex 13350 Nov  9 08:11 info.bash
        -rw-rw-r-- 1 alex alex 15935 Nov  9 08:11 all.bash

And also some commands (without extension):

        -rwxrwxr-x 1 alex alex   549 Nov  9 08:23 log
        -rwxrwxr-x 1 alex alex 79640 Nov  9 08:23 sendmail

> All files are self contained, so you only pick the ones you need. They are also slightly
> compressed for better load time.

### Including libraries

The most common way is to include the needed library from the `dist` folder above within the destination code. That ensures that changes to the bash-lib repository or a central installation won't change the running code.

As already said, all files are self contained without further references. So copy the needed library as `lib.bash` to your project and include it relatively.

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/lib.bash"
```

### Standalone Commands

To use them on a machine, copy the `dist` folder to a central position and use it from there. This will often be in `/opt` or `/opt/divibib/` and also included in the path:

    cp dist /opt/bash-lib
    echo "PATH=\"$PATH:/opt/bash-lib\"" >> ~/.bashrc

But you can also always copy the command directly to any other folder and use it from there.

### Short usage

To only use it in single bash script, put the library directly beside your script:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/base.bash"

# here you can use it
```

But if it belongs to the administration tasks it is often better for the overview to add it to the already existing [admin-utils](/divibib-betrieb/admin-utils).

## Programs

This is a list of all included programs, which can be also called directly from bash:

-   `log` command to write to file, `STDERR` or syslog
-   `sendmail` is a simple SMTP mailer
-   `csv2html` convert CSV data into a simple HTML table
-   `csv2xls` convert CSV data into an binary XLS file
-   `install` to initially setup (see above)

### Default options

All commands supports some default options:

-   `-h --help` to show a short help integrated page
-   `-V --version` displays the version of this program

To separate parameters to the command from options a double `--` can be used.

## Libraries

Methods may return two different parts:

-   `$?` exit code which is 0 on success
-   direct console output which may be captured or be piped
    (internal commands will directly call the log module so no need to do this here)

The following modules are available:

-   [core](src/include/core.md) general small helpers
-   [colors](src/include/colors.md) colorization methods
-   [log](src/include/log.md) log handler to write to file, `STDERR` or syslog
-   [process](src/include/process.md) serialize or parallelize tasks
-   [psql](src/include/psql.md) to access PostgreSQL Database
-   [info](src/include/info.md) is a collection of system information methods

Additionally a [skeleton](src/skeleton.md) is used as template to create new scripts.

### Minified libraries

If you need the above libraries, don't use them directly, better use one of the combined collections. Each package contains some or all of the libraries:

-   `all` including core, colors, log, locking, info, psql
-   `base` including core, colors, log
-   `psql` including core, colors, log, psql
-   `process` including core, colors, log, process
-   `info` including core, colors, log, info

Select the one you need and copy it to your application.

> You should always only include one library. If you need multiple functions, include a bigger one.

## Internal processing

The internal `bin/build` command will make the distribution files by:

-   combining the bash libs
-   removing comments and white-space
-   replacing some variables

The result can be found in the `dist` folder.

Which libraries to build and what is included is configured within the [build script](bin/build).

### Library inclusion

To include a library within a command put a comment exactly like below in the code:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))

# DIST include base.bash
source "$source_dir/../include/log.bash" # load log handler
```

That will directly include the `base.bash` at the position of this comment and remove the line behind which is the `source` line.

### Variable replacement

The following variables will be replaced by their values:

In bash:

-   `VERSION=...`
-   `REVISION=...`
-   `GITLAB=...`

In Perl:

-   `###VERSION###`
-   `###REVISION###`
-   `###GITLAB###`
