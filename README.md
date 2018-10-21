# Bash Helper

> Helper programs and libraries for administration tool development (mostly in bash).

A short help is always included in the files but the [documentation section](doc/README.md) may have further information with usage examples for each library.

## Installation

### Within Repository

If used in other git projects, it should be added as git submodule and included in the scripts using relative paths. But don't forget to make it relative from the current script directory because the working directory may change depending from where the script is called.

```bash
source_dir=$(dirname "${BASH_SOURCE[0]}")
source "$source_dir/bash-lib/include/colors"
```

### Standalone

To use them from out of a git repository you have to copy the code to the machine. This will often be in `/opt` or `/opt/divibib/` and included from your scripts with it's absolute path.

To easily call the contained programs you may add `/opt/bash-lib` to the search path.

## Programs

- [log](doc/log.md) log command to write to file, `STDERR` or syslog
- [sendmail](doc/sendmail.md) is a simple SMTP mailer

## Libraries

Methods may return three different parts:

- `$?` exit code which is 0 on success
- `$result` from the called method if possible
- direct console output which may be captured or be piped
  (internal commands will directly call the log module so no need to do this here)

The following modules are available:

- [locking](doc/locking.md) to serialize parallel tasks
- [log](doc/log.md) log handler to write to file, `STDERR` or syslog
- [colors](doc/colors.md) predefined color variables
- [info](doc/info.md) is a collection of system information methods

Additionally a [skeleton](doc/skeleton.md) is used as template to create new scripts.
