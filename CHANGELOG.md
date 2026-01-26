# Last Changes

Newest changes will always take part in the development branch. You only may use them if you manually install this.
But on release they will be merged with semantical versioning into the master branch and will get available to new installs or updates.

## Development - v2.5.0

- move down deprecated methods

## 26. January 2026 - v2.4.0

- allow to include BashLib directly from the net in special remote version
- add [big_files](doc/function/big_files.md) analyzation
- add [git_info](doc/function/git_info.md) and [git_log](doc/function/git_log.md) helper
- add [pw_generator](doc/function/pw_generator.md)
- add [uppercase](doc/function/uppercase.md) and [lowercase](doc/function/lowercase.md) methods
- add [compress](doc/function/compress.md) and [decompress](doc/function/decompress.md)
- add [uprintf](doc/function/uprintf.md) which is a multi-byte safe version of `printf`
- enhance the [os](doc/function/os.md) and add [bios](doc/function/bios.md) information
- move join -> [array](doc/function/array.md) command
- enhance [hash](doc/function/hash.md) to tsv
- [choose](doc/function/choose.md) now with multi column display
- rename ip -> [ip_resolve](doc/function/ip_resolve.md)
- fix installer to also allow installation of develop version
- fix in option_parse to always return true
- move down deprecated methods

## 11. January 2026 - v2.3.0

- add [trivy](doc/function/trivy.md) security scanning
- add [jira](doc/function/jira.md) search, get, create, update and delete for issues with included ADF parser/formatter
- add `--message` option to [is](doc/function/is.md) for usage information
- [is](doc/function/is.md) now also handles check with --output option into variable or stdout
- new [is](doc/function/is.md)/[check](doc/function/check.md) validators: true/false, date
- add [process](doc/function/process.md) analyzation and management
- add [sleep_until](doc/function/sleep_until.md)
- add [first](doc/function/first.md)
- add [ip](doc/function/ip.md) to resolve hosts
- add `$CONFIG` to load special config file
- add escape sequences and function for cursor management on terminal
- add [logo](doc/function/logo.md) to display it
- rename `config/overwrite` to `config/local`
- option_parse with support for optional values
- rename color -> ansi module and add the cursor, character and clear codes
- optimize code echo and escape sequences
- optimize function documentation
- move down deprecated methods

## 22. December 2025 - v2.2.0

- add [log](./doc/function/log.md) support
- completed the [queue](doc/function/queue.md) for parallel job execution
- filesystem checks for `is` and `check` function
- functions validate parameters using [is](doc/function/is.md) and [check](doc/function/check.md)
- extend stack traces to show also code lines through [die](doc/function/die.md)
- catch each error and output a failure with stack trace through [die](doc/function/die.md)
- combine `timer_start` and `timer_end` into [timer](doc/function/timer.md)
- combine all remote* functions together into [remote](doc/function/remote.md)
- combine env_* functions into [variables](doc/function/variables.md)
- added [jira](doc/function/jira.md) function to work with issues
- add support for Arch/Manjaro/Kali Linux and RedHat/CentOS/Fedora
- switch to git flow in development to have a more stable master branch

## 21. November 2025 - V2.1.0

- Deprecated as warning and `die` possible
- integrate ip pattern mapping to detect provider, network segment or VMware link
- simplified remote invocation using [`remote_bashlib`](doc/function/remote_bashlib.md)
- [options](doc/function/option_parse.md) can now also work without permutation
- all ['remote`](doc/function/remote.md) functions now support a jump host
- restructure network and os module and its functions
- [`ask`](doc/function/ask.md) now with multiline and external editor support
- add [remote_bashlib](doc/function/remote_bashlib.md) to run any bashlib command on remote host
- add [mongo](doc/function/mongo.md) connection
- move `remote_df` and `remote_lvm` into os module
- move color, array and validator module into core
- add [to_alphanum](doc/function/to_alphanum.md) to make possible hash keys
- add [hash](doc/function/hash.md) function
- more alpine support
- add [csv](doc/function/csv.md) and [tsv](doc/function/tsv.md) manipulation

## 05. November 2025 - V2.0.1

- fix: `_deprecated` display correct function
- fix: `mktemp` if already existing to also return path
- fix: `tasks` to work with quoted arguments in function calls
- restructure tests folder for better overview
- [`pause`](doc/function/pause.md) now also has timeout and abort
- [`confirm`](doc/function/confirm.md) timeout and display of invalid input
- [`ask`](doc/function/ask.md) invalid input, timeout
- [`choose`](doc/function/choose.md) invalid input, `--timeout`, input format check, direct selection without `<return>`
- [`tasks`](doc/function/tasks.md) with `--loop` option
- [`ask password`](doc/function/ask.md) input with strength display while typing
- test suite now runs in debian/ubuntu completely and the core in alpine, too

## 28. October 2025 - V2.0.0

- enhanced and easy to use [`debug`](doc/function/debug.md) possibilities
- stacktrace in debug level 5 integrated to [`die`](doc/function/die.md)
- add [`spinner_start`](doc/function/spinner_start.md) animation
- [`dns-list`](doc/function/dns_list.md) to query self controlled dns servers
- a new **timer** to measure elapsed time between two invocations
- improved [`ask`](doc/function/ask.md) which allows only valid characters for specified input
- operating system tests in local docker and using GitLab CI

## 20. October 2025 - V2 Beta

- **Complete rework** of the BashLib as BashLib V2 New Generation
- **modular** concept integrated
- **simplified** usage by only including one line
- added an **installation** script callable directly from the git url
- unit **testing** integrated
- **multilingual** support with EN, DE at first
- **interactive** support: pause, ask_string, ask_integer, ...
- remote capabilities integrated: **ssh, curl, Prometheus, Grafana, Confluence, Jira, Mattermost**
- completely **documented** with [API](doc/README.md)

What was before this, was BashLib V1 and as everything is new it doesn't matter any more.
