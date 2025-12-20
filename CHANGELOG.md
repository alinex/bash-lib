# Last Changes

As this is not driven by releases and therefore tags are not used it is an ongoing update so we will divide the changelog into months. If you need a special version instead of the newest one, please select it in git by date.

## December Version - v2.2.0

- let functions validate parameters using [is](doc/function/is.md) and [check](doc/function/check.md)
- filesystem checks for `is` and `check` function
- extend stack traces to show also code lines through [die](doc/function/die.md)
- catch each error and output a failure with stack trace through [die](doc/function/die.md)
- add [log](./doc/function/log.md) support
- combine `timer_start` and `timer_end` into [timer](doc/function/timer.md)
- combine all remote* functions together into [remote](doc/function/remote.md)
- combine env_* functions into [variables](doc/function/variables.md)
- added [jira](doc/function/jira.md) function to work with issues
- completed the [queue](doc/function/queue.md) for parallel job execution
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
