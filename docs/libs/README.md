title: Overview

# Libraries

Methods may return two different parts:

-   `$?` exit code which is 0 on success
-   direct console output which may be captured or be piped
    (internal commands will directly call the log module so no need to do this here)

The following modules are available:

-   [core](core.md) general small helpers
-   [colors](colors.md) colorization methods
-   [log](log.md) log handler to write to file, `STDERR` or syslog
-   [process](process.md) serialize or parallelize tasks
-   [psql](psql.md) to access PostgreSQL Database
-   [info](info.md) is a collection of system information methods

{!docs/assets/abbreviations.txt!}
