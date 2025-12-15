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

The configuration module contains a lot of general configuration settings for the bash-lib modules itself. Most of them are specific to the individual environment so they need to be set in the local `overwrite` config.

| Variable/Function | Description |
| --- | --- |
| ``$MOUNT_COLOR_LIMIT`` | Array: Color limits per mount (regex critical error warn ok) used in [`df`](functiondf.md) |
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
| ``$CONFLUENCE_API`` | Atlassian confluence API URL used together with `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` and silently disables [`confluence`](functionconfluence.md) functions if not set |
| ``$JIRA_API`` | Atlassian jira API URL used together with `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` and silently disables [`jira`](functionjira.md) functions if not set |
| ``$REMOTE_LOGIN_DEFAULT`` | Default login if no `--login` or ``$login`` available |
| ``$MONGO_ADMIN_USERPASS`` | Hash: Mongo Admin User Logins `<host> = <username>:<password>` but use `_` instead of `.` in hostname |
| ``$POWERDNS_API`` | PowerDNS API URL used together with `$POWERDNS_TOKEN` and silently disables powerdns function if not set |
| ``$POWERDNS_TOKEN`` | PowerDNS API Token used together with `$POWERDNS_API` in dns function |
| ``$PLUSSERVER_PORTAL`` | Base URL for Portal to Provider Plusserver |
| ``$CONFLUENCE_OUTAGE`` | Atlassian confluence page id for outage information [`confluence_outage`](functionconfluence_outage.md) |

## Core

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

### Color Module

This module contains color specifications to be used in console output.

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
| [`color_256`](function/color_256.md) | Get color code for text color number |
| [`color_256_bg`](function/color_256_bg.md) | Get color code for background color number |
| [`color_table`](function/color_table.md) | Show complete color table |

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
| [`erase_line`](function/erase_line.md) | Remove current line |
| [`horizontal_line`](function/horizontal_line.md) | Show a horizontal line |
| [`spinner_start`](function/spinner_start.md) | Function to start the spinner in the background |
| [`spinner_stop`](function/spinner_stop.md) | Function to stop the spinner |

### Validator Module

Validators to make this easier and more readable.

| Variable/Function | Description |
| --- | --- |
| [`check`](function/check.md) | Validate and sanitize values. |
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
| [`jira_search`](function/jira_search.md) | Search for jira tickets |
| [`jira_get`](function/jira_get.md) | Get jira ticket details |
| [`jira_create`](function/jira_create.md) | Create jira tickets |
| [`jira_update`](function/jira_update.md) | Update jira tickets |

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
| [`log`](function/log.md) | Additional logging (at the moment only into files). |

### Mattermost Module

Using the mattermost API to write messages.

| Variable/Function | Description |
| --- | --- |
