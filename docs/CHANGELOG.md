# Last Changes

## Unpublished

-   added status in middleware detection
-   added more info methods for current load and memory usage

## Version 1.3.1 (22.01.2020)

-   command logging fixed (had problems if called through sudo or cron)
-   error detection optimized in logging
-   Optimized logging within lock/unlock
-   Support the TRACE level in logging to be more detailed as DEBUG

## Version 1.3.0 (05.07.2019)

-   support piped input in `psql_exec`
-   increase info package with
    -   hardware detection
    -   geo location
    -   package analyzation
    -   user and crontab analyzation
-   support for more linux OS versions in detection
-   automatic unit testing based on shunit2
-   add sudo support to core

## Version 1.2.1 (21.02.2019)

-   fix process locking in `lock`
-   add changelog
-   add readme, license and changelog to distribution

## Version 1.2.0 (29.12.2018)

-   made repository public available
-   add [MkDocs](https://alinex.gitlab.io/env/mkdocs) based website
-   restructure documentation
-   move skeleton to documentation
-   add clear license information
-   add downloads for distribution files

## Version 1.1.0 (07.12.2018)

-   compress multiline commands
-   update documentation
-   update online help

## Version 1.0.3 (05.12.2018)

-   remove character conversion for psql_csv
-   fix lock_exit to really work
-   log started steps in process
-   update process documentation

## Version 1.0.2 (02.12.2018)

-   change code style

## Version 1.0.1 (28.11.2018)

-   update documentation
-   fix OS detection for Debian
-   fix csv -> html conversion for psql
-   fix psql error checking
-   add core lib for path

## Version 1.0.0 (25.11.2018)

-   color management
-   log handler
-   locking management
-   psql integration
-   info module
