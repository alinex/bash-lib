title: Overview

# Libraries

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
