# Bash Helper

> Helper programs and libraries for administration tool development (mostly in bash).

A short help is always included in the files but this documentation contains further information with usage examples for each library.

## Installation

### Build

This library contains a build script under `bin/build` which should be called to create the distribution folder.

After that you will find different combined libraries in the `dist` folder:

        -rw-rw-r-- 1 alex alex  9994 Nov  9 08:11 base.bash
        -rw-rw-r-- 1 alex alex 10970 Nov  9 08:11 psql.bash
        -rw-rw-r-- 1 alex alex 11603 Nov  9 08:11 locking.bash
        -rw-rw-r-- 1 alex alex 13350 Nov  9 08:11 info.bash
        -rw-rw-r-- 1 alex alex 15935 Nov  9 08:11 all.bash

And also some commands:

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

To use them on a machine, copy the `dist` folder to a central position and use it from there. This will often be in `/opt` or `/opt/divibib/` and included in the path:

    cp dist /opt/bash-lib
    echo "PATH=\"$PATH:/opt/bash-lib\"" >> ~/.bashrc

But you can also always copy the command directly to any other folder and use it from there.

## Programs

- [log](src/bin/log.md) log command to write to file, `STDERR` or syslog
- [sendmail](src/bin/sendmail.md) is a simple SMTP mailer

## Libraries

Methods may return two different parts:

- `$?` exit code which is 0 on success
- direct console output which may be captured or be piped
  (internal commands will directly call the log module so no need to do this here)

The following modules are available:

- [core](src/include/core.md) general small helpers
- [colors](src/include/colors.md) colorization methods
- [log](src/include/log.md) log handler to write to file, `STDERR` or syslog
- [process](src/include/process.md) serialize or parallelize tasks
- [psql](src/include/psql.md) to access PostgreSQL Database
- [info](src/include/info.md) is a collection of system information methods

Additionally a [skeleton](src/skeleton.md) is used as template to create new scripts.

## Minified libs

This all is packaged in the following distribution libraries (see install above):

- `all` including colors, log, locking, info, psql
- `base` including colors, log
- `psql` including colors, log, psql
- `process` including colors, log, process
- `info` including colors, log, info

## Internal processing

The internal `bin/build` command will make the distribution files by:

- combining the bash libs
- removing comments and white-space
- replacing some variables

The result can be found in the `dist` folder.

Which libraries to build and what is included is configured within the [build script](bin/build).

### Library inclusion

To include a library within a command put a comment exactly like below in the code:

```bash
# DIST include base.bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/../include/log.bash" # load log handler
```

That will directly include the `base.bash` at the top of the command. The `source` line will be removed.

### Variable replacement

The following variables will be replaced by their values:

In bash:

- `VERSION=...`
- `REVISION=...`
- `GITLAB=...`

In Perl:

- `###VERSION###`
- `###REVISION###`
- `###GITLAB###`
