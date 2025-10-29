# Last Changes

As this is not driven by releases and therefore tags are not used it is an ongoing update so we will divide the changelog into months. If you need a special version instead of the newest one, please select it in git by date.

## Ongoing

- fix: `_deprecated` display correct function
- fix: `mktemp` if already existing to also return path
- fix: `tasks` to work with quoted arguments in function calls
- restructure tests folder for better overview

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
- remote capabilities integrated: **ssh, curl, prometheus, grafana, confluence, jira, mattermost**
- completely **documented** with [API](doc/README.md)

What was before this, was BashLib V1 and as everything is new it doesn't matter any more.
