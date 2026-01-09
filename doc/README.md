# BashLib API Documentation

This is a list of some examples and the reference documentation of all available modules.

## Table of Contents

- [BashLib API Documentation](#bashlib-api-documentation)
  - [Table of Contents](#table-of-contents)
  - [Examples](#examples)
  - [Config](#config)
    - [Environment Module](#environment-module)
  - [Core](#core)
    - [Arguments Module](#arguments-module)
    - [Config Module](#config-module)
    - [Date Module](#date-module)
    - [Internal Module](#internal-module)
    - [Misc Module](#misc-module)
  - [Module](#module)
    - [Array Module](#array-module)
    - [Atlassian Module](#atlassian-module)
    - [Color Module](#color-module)
    - [File Module](#file-module)
    - [Input Module](#input-module)
    - [Mattermost Module](#mattermost-module)
    - [Monitoring Module](#monitoring-module)
    - [Os Module](#os-module)
    - [Output Module](#output-module)
    - [Process Module](#process-module)
    - [Remote Module](#remote-module)
    - [Software Module](#software-module)
    - [Validator Module](#validator-module)
  - [Extra](#extra)
    - [Divibib Module](#divibib-module)

## Examples

The examples should be a good start to see what and how it is possible:

- [Base Script](./example/base_script.md)
- [Parameters and Options](./example/options.md)
- [Shared Memory](./example/shared_memory.md)
- [User Interaction](example/input.md)
- [Tasks](./example/tasks.md)
- [Mattermost](./example/mattermost.md)

The BashLib contains some core functionality and optional modules which are listed below.

## Config

### Environment Module

The configuration module contains a lot of general configuration settings for the bash-lib modules itself. Most of them are specific to the individual environment so they need to be set in the `local` config.

| Variable/Function | Description |
| --- | --- |
| ``$QUEUE_MAX_NUM`` | Maximum number of parallel tasks for queue |
| ``$QUEUE_MAX_LOAD`` | Percentage of 1 Minute Load per CPU (100% 8Cpu => 8.0) |
| ``$REMOTE_LOGIN_DEFAULT`` | Default login if no `--login` or ``$login`` available |
| ``$MOUNT_COLOR_LIMIT`` | Array: Color limits per mount (regex critical error warn ok) used in [`df`](functiondf.md) |
| ``$IP_PROVIDER_PATTERN`` | Array: Provider selection per ip (regex provider) used in [`ip_pattern`](functionip_pattern.md) |
| ``$IP_SEGMENT_PATTERN`` | Array: Network segment selection per ip (regex segment) used in [`ip_pattern`](functionip_pattern.md) |
| ``$MATTERMOST_API`` | Mattermost API URL used together with `$MATTERMOST_TOKEN` and silently disables mattermost functions if not set |
| ``$MATTERMOST_TOKEN`` | Mattermost API Token used in [`mattermost`](functionmattermost.md) [`mattermost_repost`](functionmattermost_repost.md) [`mattermost_reaction`](functionmattermost_reaction.md) |
| ``$MATTERMOST_CHANNEL_PATTERN`` | Array: Channel per pattern (team regex channel) used in [`mattermost`](functionmattermost.md) ("-"" = no selection for team) |
| ``$MATTERMOST_LINK_PATTERN`` | Array: Link channel per pattern (team regex channel) used in [`mattermost`](functionmattermost.md) ("-"" = no selection for team) |
| ``$GRAFANA_API`` | Grafana API URL used together with `$GRAFANA_TOKEN` and silently disables Grafana functions if not set |
| ``$GRAFANA_TOKEN`` | Grafana API Token used in [`alerts`](functionalerts.md) |
| ``$PROMETHEUS_API`` | Prometheus API URLs as space separated list |
| ``$PROMETHEUS`` | Prometheus host names as space separated list |
| ``$ATLASSIAN_USER`` | Atlassian user for API access in confluence and jira |
| ``$ATLASSIAN_TOKEN`` | Atlassian password for API access in confluence and jira |
| ``$JIRA_HOST`` | Atlassian Jira URL this can be https://my-company.atlassian.net |
| ``$CONFLUENCE_API`` | Atlassian confluence API URL used together with `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` and silently disables [`confluence`](functionconfluence.md) functions if not set |
| ``$JIRA_API`` | Atlassian jira API URL used together with `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` and silently disables [`jira`](functionjira.md) functions if not set |
| ``$TRIVY_JIRA_BOARD`` | Security Board key in Jira (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_ISSUE_TYPE`` | Type of issue to use for these (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_FIELD_SOURCES`` | Field name for multiline text of sources (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_FIELD_RATING`` | Field name for rating string (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_FIELD_VERSION`` | Field name for fixed version string (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_FIELD_LINKS`` | Field name for multiline text with further links (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_FIELD_APPROVAL`` | Field name for approval status (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_APPROVAL_TEMP`` | Value in approval field for "allowed for 30 days" (if trivy vulnerabilities are managed using Jira) |
| ``$TRIVY_JIRA_APPROVAL_IRRELEVANT`` | Value in approval field for irrelevant/always allowed (if trivy vulnerabilities are managed using Jira) |
| ``$REMOTE_LOGIN_DEFAULT`` | Default login if no `--login` or ``$login`` available |
| ``$MONGO_ADMIN_USERPASS`` | Hash: Mongo Admin User Logins `<host> = <username>:<password>` but use `_` instead of `.` in hostname |
| ``$POWERDNS_API`` | PowerDNS API URL used together with `$POWERDNS_TOKEN` and silently disables powerdns function if not set |
| ``$POWERDNS_TOKEN`` | PowerDNS API Token used together with `$POWERDNS_API` in dns function |
| ``$PLUSSERVER_PORTAL`` | Base URL for Portal to Provider Plusserver |
| ``$TRIVY_DEFAULT_TIMEOUT`` | Maximum time to generate trivy security report |
| ``$TRIVY_CACHE_SERVER`` | Optional, use specified trivy server for caching of the internet databases |
| ``$CONFLUENCE_OUTAGE`` | Atlassian confluence page id for outage information [`confluence_outage`](functionconfluence_outage.md) |

## Core

### Ansi Module

This module contains ANSI escape constants and helpers for color, cursor move, clear and more.

| Variable/Function | Description |
| --- | --- |
| ``$COLORS`` | Number of colors possible on terminal |
| ``$CC_RESET`` | Reset all |
| ``$CC_RESET_FG`` | Reset text color |
| ``$CC_RESET_BG`` | Reset background color |
| ``$CC_INTENSITY_BOLD`` | Set intensity to bold |
| ``$CC_INTENSITY_LIGHT`` | Set intensity to light |
| ``$CC_INTENSITY_OFF`` | Set intensity back to normal |
| ``$CC_ITALIC`` | Set italic mode |
| ``$CC_ITALIC_OFF`` | Unset italic mode |
| ``$CC_UNDERLINE`` | Set underline mode |
| ``$CC_UNDERLINE_OFF`` | Unset underline mode |
| ``$CC_INVERSE`` | Set inverse mode (change text color and background color) |
| ``$CC_INVERSE_OFF`` | Unset inverse mode |
| ``$CC_DASHED`` | Set strike through mode |
| ``$CC_DASHED_OFF`` | Unset strike through mode |
| ``$CC_BLACK`` | Set text color to black |
| ``$CC_RED`` | Set text color to red |
| ``$CC_GREEN`` | Set text color to green |
| ``$CC_YELLOW`` | Set text color to yellow |
| ``$CC_BLUE`` | Set text color to blue |
| ``$CC_MAGENTA`` | Set text color to magenta |
| ``$CC_CYAN`` | Set text color to cyan |
| ``$CC_WHITE`` | Set text color to white |
| ``$CC_BLACK_BOLD`` | Set text color to bold black |
| ``$CC_RED_BOLD`` | Set text color to bold red |
| ``$CC_GREEN_BOLD`` | Set text color to bold green |
| ``$CC_YELLOW_BOLD`` | Set text color to bold yellow |
| ``$CC_BLUE_BOLD`` | Set text color to bold blue |
| ``$CC_MAGENTA_BOLD`` | Set text color to bold magenta |
| ``$CC_CYAN_BOLD`` | Set text color to bold cyan |
| ``$CC_WHITE_BOLD`` | Set text color to gray |
| ``$CC_BLACK_BG`` | Set background color to black |
| ``$CC_RED_BG`` | Set background color to red |
| ``$CC_GREEN_BG`` | Set background color to green |
| ``$CC_YELLOW_BG`` | Set background color to yellow |
| ``$CC_BLUE_BG`` | Set background color to blue |
| ``$CC_MAGENTA_BG`` | Set background color to magenta |
| ``$CC_CYAN_BG`` | Set background color to white |
| ``$CC_BLACK_BOLD_BG`` | Set background color to bold black |
| ``$CC_RED_BOLD_BG`` | Set background color to bold red |
| ``$CC_GREEN_BOLD_BG`` | Set background color to bold green |
| ``$CC_YELLOW_BOLD_BG`` | Set background color to bold yellow |
| ``$CC_BLUE_BOLD_BG`` | Set background color to bold blue |
| ``$CC_MAGENTA_BOLD_BG`` | Set background color to bold magenta |
| ``$CC_CYAN_BOLD_BG`` | Set background color to bold cyan |
| ``$CC_CRITICAL`` | Set color for critical/disaster massages |
| ``$CC_ERROR`` | Set color for error messages and failures |
| ``$CC_WARN`` | Set color for warnings |
| ``$CC_NOTICE`` | Set color for highlighted information |
| ``$CC_OK`` | Set color for success messages |
| ``$CC_HEADING`` | Set color for block headings |
| ``$CC_INVERS`` | Set color for highlighted parts like table header |
| ``$CURSOR_UP`` | Cursor up 1 line |
| ``$CURSOR_DOWN`` |  Cursor down 1 line |
| ``$CURSOR_RIGHT`` |  Cursor right 1 col |
| ``$CURSOR_LEFT`` | Cursor left 1 col |
| ``$CURSOR_NEXT`` | Next Line (down, col 1) |
| ``$CURSOR_PREVIOUS`` | Previous Line (up, col 1) |
| ``$CURSOR_POS1`` | Cursor to start of line |
| ``$CURSOR_TOP`` | Cursor to top-left |
| ``$CURSOR_STORE`` | Save cursor pos |
| ``$CURSOR_RESTORE`` | Restore cursor pos |
| ``$CURSOR_SHOW`` | Show cursor |
| ``$CURSOR_HIDE`` | Hide cursor |
| ``$SCROLL_UP`` | Reverse Index (up, scroll) |
| ``$CLEAR_SCREEN`` | Clear entire screen |
| ``$CLEAR_UP`` | Clear from start of screen to cursor |
| ``$CLEAR_DOWN`` | Clear from cursor to end of screen |
| ``$CLEAR_EOL`` | Clear from cursor to end of line |
| ``$CLEAR_SOL`` | Clear from start of line to cursor |
| ``$CLEAR_LINE`` | Clear entire line |
| ``$SCREEN_RESTORE`` | restore screen |
| ``$SCREEN_SAVE`` | save screen |
| [`color_256`](function/color_256.md) | Get color code for text color number |
| [`color_256_bg`](function/color_256_bg.md) | Get color code for background color number |
| [`color_table`](function/color_table.md) | Show complete color table |
| [`cursor`](function/cursor.md) | Move cursor on console |
| [`character`](function/character.md) | Change characters |
| [`erase_line`](function/erase_line.md) | Deprecated: Remove current line |

### Arguments Module

This should help to read function parameters/arguments in different ways.

| Variable/Function | Description |
| --- | --- |
| [`option_parse`](function/option_parse.md) | Parse arguments based on given specification |
| [`option_help`](function/option_help.md) | Print help for options defined in options specification |
| [`input`](function/input.md) | Collect string from stdin (no parameters) or concatenate the parameters |
| [`input_args`](function/input_args.md) | Collect string from stdin (not more than defined parameters) or concatenate the parameters |
| [`input_lines`](function/input_lines.md) | Collect string from stdin (no parameters) or parameters each as a line |
| [`escape_args`](function/escape_args.md) | Escape all args into single string, this could not be used directly in commands as arguments only through eval |

### Array Module

Helper functions to work with arrays and associative arrays (hashes).

| Variable/Function | Description |
| --- | --- |
| [`contains`](function/contains.md) | Deprecated: Check if value is contained in array |
| [`array`](function/array.md) | Array analyzation. |
| [`join`](function/join.md) | Join array elements by delimiter |
| [`split`](function/split.md) | Splits string by delimiter into array |
| [`hash`](function/hash.md) | Methods to work with assoziative arrays (hashes) |

### Config Module

The core configuration which is needed for the core functions.

| Variable/Function | Description |
| --- | --- |
| ``$BASHLIB_HOME`` | Set in the environment to where the BASHLIB is installed |
| ``$DEBUG`` | Set to level 0..9 (higher is more verbose) or specify function patterns as comma separated list |
| ``$CC_RESET`` | Reset all |
| ``$CC_CRITICAL`` | Set color for critical/disaster massages used by [`die`](functiondie.md) |
| ``$CC_BLACK`` | Set text color to black |

### Date Module

Some helpers to work easier with dates.

| Variable/Function | Description |
| --- | --- |
| [`now`](function/now.md) | Get current timestamp |
| [`date_diff`](function/date_diff.md) | Calculate difference in seconds |
| [`date_format`](function/date_format.md) | Format date in different named versions or format string |
| [`sleep_until`](function/sleep_until.md) | Sleep until given date |
| [`duration_format`](function/duration_format.md) | Format duration in different numbers or human readable |
| [`timer`](function/timer.md) | Start/stop the timer |
| [`timer_start`](function/timer_start.md) | Deprecated: Start the timer |
| [`timer_stop`](function/timer_stop.md) | Deprecated: Stop the timer and calculate elapsed time |

### Misc Module

The core functions contains essential parts which may also be used while loading the library.

| Variable/Function | Description |
| --- | --- |
| ``$CURL_HTTP_CODE`` | Last HTTP return code from curl |
| [`use`](function/use.md) | Load bashlib module |
| [`trap_add`](function/trap_add.md) | Set or add an additional trap without overwriting existing ones |
| [`trap_remove`](function/trap_remove.md) | Remove a specific trap |
| [`mktemp`](function/mktemp.md) | Make a temporary file, which can be recognizable/individual |
| [`curl`](function/curl.md) | Curl with added error handling |
| [`first`](function/first.md) | Get the first value that is non-empty |

### Output Module

Module with output and user interaction helpers.

| Variable/Function | Description |
| --- | --- |
| [`debug`](function/debug.md) | Write message to STDERR if in DEBUG mode else do nothing |
| [`die`](function/die.md) | Output error message and exit |
| [`help`](function/help.md) | Show help page and exit |
| [`heading`](function/heading.md) | Print block heading |
| [`critical`](function/critical.md) | Print critical/disaster message |
| [`error`](function/error.md) | Print error message |
| [`warn`](function/warn.md) | Print warning message |
| [`notice`](function/notice.md) | Print special information message |
| [`info`](function/info.md) | Print special information message |
| [`ok`](function/ok.md) | Print success message |
| [`invers`](function/invers.md) | Print special marked message like table header |
| [`color`](function/color.md) | Print message in defined color |
| [`uncolorize`](function/uncolorize.md) | Remove color codes from text |
| [`html2md`](function/html2md.md) | Convert HTML to markdown (simplified version) |
| [`nocr`](function/nocr.md) | Remove carriage return from line endings |
| [`urlencode`](function/urlencode.md) | Encode message to be used within the url |
| [`horizontal_line`](function/horizontal_line.md) | Show a horizontal line |
| [`spinner_start`](function/spinner_start.md) | Function to start the spinner in the background |
| [`spinner_stop`](function/spinner_stop.md) | Function to stop the spinner |
| [`logo`](function/logo.md) | Output Logo with title text |

### Validator Module

Validators to make this easier and more readable.

| Variable/Function | Description |
| --- | --- |
| [`check`](function/check.md) | Deprecated:Validate and sanitize values. |
| [`is`](function/is.md) | Validate and sanitize values. |
| [`num_parameters`](function/num_parameters.md) | Deprecated: Check that a specific number of parameters are given |
| [`is_empty`](function/is_empty.md) | Deprecated: Test if given value is an empty string or undefined |
| [`is_integer`](function/is_integer.md) | Deprecated: Test if given value is an integer |
| [`is_float`](function/is_float.md) | Deprecated: Test if given value is an float |
| [`trim_start`](function/trim_start.md) | Trim leading whitespace or given character |
| [`trim_end`](function/trim_end.md) | Trim trailing whitespace or given character |
| [`trim`](function/trim.md) | Trim leading and trailing whitespace or given character |
| [`to_alphanum`](function/to_alphanum.md) | Convert string into only alphanumeric values |
| [`value_if_variable`](function/value_if_variable.md) | Return the value or if it is a variable name which is not empty return it's value |

## Module

### Atlassian Module

This covers Atlassian API for Jira and confluence.

| Variable/Function | Description |
| --- | --- |
| [`confluence`](function/confluence.md) | Get page content from Confluence using API |
| [`jira`](function/jira.md) | Jira API calls |

### Database Module

Module with database access helpers.

| Variable/Function | Description |
| --- | --- |
| [`mongo`](function/mongo.md) | Run command on Mongo DB |
| [`postgres`](function/postgres.md) | Run command on Postgres |

### Dns Module

Module with DNS methods.

| Variable/Function | Description |
| --- | --- |
| [`dns_list`](function/dns_list.md) | Query all managed DNS servers to get a complete list of domain names |
| [`powerdns`](function/powerdns.md) | Query PowerDNS to get a list of managed domain names |
| [`plusserver_dns`](function/plusserver_dns.md) | Query Plusserver DNS to get a list of managed domain names |

### File Module

File and directory helpers.

| Variable/Function | Description |
| --- | --- |
| [`basename`](function/basename.md) | Strip directory from filepath |
| [`dirname`](function/dirname.md) | Strip last component from file path |
| [`extname`](function/extname.md) | Returns the extension of the path |
| [`script_path`](function/script_path.md) | Get the path from the called command |

### Input Module

Module with user interaction helpers.

| Variable/Function | Description |
| --- | --- |
| [`pause`](function/pause.md) | Wait for some time or user input |
| [`confirm`](function/confirm.md) | Ask a yes/no question. |
| [`ask_no`](function/ask_no.md) | Deprecated: Ask yes/no question with default to no. |
| [`ask_yes`](function/ask_yes.md) | Deprecated: Ask yes/no question with default to yes. |
| [`ask_input`](function/ask_input.md) | Deprecated: Ask a free question. |
| [`ask`](function/ask.md) | Ask for an input element |
| [`choose`](function/choose.md) | Select from list (extended version of native select) |
| [`tasks`](function/tasks.md) | Run tasks as selected by user |

### Log Module

Logging addition for output module.

| Variable/Function | Description |
| --- | --- |
| [`log`](function/log.md) | Additional logging (at the moment only into files) |

### Mattermost Module

Using the mattermost API to write messages.

| Variable/Function | Description |
| --- | --- |
| [`mattermost`](function/mattermost.md) | Send a message to Mattermost |
| [`mattermost_attachment`](function/mattermost_attachment.md) | Create an attachment json to be used in post |
| [`mattermost_reaction`](function/mattermost_reaction.md) | Add reaction to existing post |
| [`mattermost_repost`](function/mattermost_repost.md) | Add response to mattermost posting |

### Monitoring Module

Using the Grafana/Prometheus APIs to get Monitoring information.

| Variable/Function | Description |
| --- | --- |
| [`exporter`](function/exporter.md) | Get exporter list |
| [`scrape`](function/scrape.md) | Scrape Prometheus exporter url now |
| [`alerts`](function/alerts.md) | Get Grafana alerts |
| [`prometheus`](function/prometheus.md) | Prom ql ausführen |
| [`prometheus_scrape_now`](function/prometheus_scrape_now.md) | Change scrape interval to scrape now and set back |

### Network Module

Module with network functions.

| Variable/Function | Description |
| --- | --- |
| [`ip`](function/ip.md) | Get IP of given hostname |
| [`ip_intern`](function/ip_intern.md) | Show the IP addresses |
| [`ip_pattern`](function/ip_pattern.md) | Find info about IP by configured patterns. |
| [`ip_extern`](function/ip_extern.md) | Run  os detection and set the constants |

### Os Module

Module with operating system specific helper functions.

| Variable/Function | Description |
| --- | --- |
| [`os_detect`](function/os_detect.md) | Detect OS settings |
| [`disk_free`](function/disk_free.md) | Disk free with visual display |
| [`uses_lvm`](function/uses_lvm.md) | Check if LVM is used |
| [`has_tty`](function/has_tty.md) | Has tty present |

### Process Module

Module for process control

| Variable/Function | Description |
| --- | --- |
| ``$STEPS_VARIABLES`` | Set the variables which should be stored with step control |
| [`sudo_allow`](function/sudo_allow.md) | Check if sudo is needed for command |
| [`sudo`](function/sudo.md) | Sudo overwrite to only use sudo if needed |
| [`repeat`](function/repeat.md) | Execute command in N times |
| [`retry`](function/retry.md) | Retry a command multiple times until it succeeds |
| [`lock`](function/lock.md) | Set a lock or wait till it can be set |
| [`lock_exit`](function/lock_exit.md) | Set the lock or exit with optional error message |
| [`unlock`](function/unlock.md) | Remove the lock |
| [`variables`](function/variables.md) | Store variables into shared memory/file |
| [`env_store`](function/env_store.md) | Deprecated: Store environment into shared memory/file |
| [`env_restore`](function/env_restore.md) | Deprecated: Restore environment from shared memory/file |
| [`env_clean`](function/env_clean.md) | Deprecated: Remove stored environment from shared memory/file |
| [`env_change`](function/env_change.md) | Deprecated: Change environment in shared memory/file |
| [`steps`](function/steps.md) | Step control allows jobs to resume on another run. |
| [`sync`](function/sync.md) | Run the given command with optional step control |
| [`async`](function/async.md) | Run the given command asynchronous ang go on in the calling routine |
| [`queue`](function/queue.md) | Run bash commands parallel with limits from a queue. |
| [`random`](function/random.md) | Return a random string in specific length |
| [`process`](function/process.md) | Process control |

### Remote Module

Module with remote calling/execution helpers.

| Variable/Function | Description |
| --- | --- |
| [`remote`](function/remote.md) | Run command on remote host. |
| [`remote_term`](function/remote_term.md) | Deprecated: Run remote command with pseudo terminal |
| [`remote_term_line`](function/remote_term_line.md) | Deprecated: Run remote command with pseudo terminal but line based output (problematic with questions) |
| [`remote_file`](function/remote_file.md) | Deprecated: Run local script on remote |
| [`remote_console`](function/remote_console.md) | Deprecated: Open an interactive console on remote host |
| [`upload`](function/upload.md) | Upload file |
| [`download`](function/download.md) | Download file |
| [`remote_bashlib`](function/remote_bashlib.md) | Deprecated: Run bashlib command on remote. |
| [`remote_install`](function/remote_install.md) | Deprecated: Remote install package like @install |
| [`remote_system_info`](function/remote_system_info.md) | Deprecated: Display the system description (from remote) |
| [`remote_df`](function/remote_df.md) | Deprecated: Remote df with visual display |
| [`remote_lvm`](function/remote_lvm.md) | Deprecated: Remote check if LVM is used |
| [`boot_wait`](function/boot_wait.md) | Wait till reboot is finished |

### Software Module

Software management functions.

| Variable/Function | Description |
| --- | --- |
| [`install`](function/install.md) | Install software package |
| [`installed`](function/installed.md) | Check for installed commands |
| [`semver`](function/semver.md) | Parse semantic version number |
| [`semver_diff`](function/semver_diff.md) | Calculate difference |

### Table Module

Module with modifiers for csv/tsv tables.

| Variable/Function | Description |
| --- | --- |
| [`tsv2table`](function/tsv2table.md) | Convert TSV data into visual table |
| [`tsv2md`](function/tsv2md.md) | Convert TSV data into markdown table |
| [`csv`](function/csv.md) | Transform comma separated table |
| [`tsv`](function/tsv.md) | Transform tab separated table |

### Trivy Module

Run trivy security scan and analyze results.

| Variable/Function | Description |
| --- | --- |
| [`trivy`](function/trivy.md) | Run a trivy security analysis. |

## Extra

### Divibib Module

Module with divibib specific helpers.

| Variable/Function | Description |
| --- | --- |
| [`logo`](function/logo.md) | divibib Logo with title text |
| [`confluence_outage`](function/confluence_outage.md) | Get outage information |
