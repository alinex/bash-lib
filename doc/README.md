# BashLib API Documentation

This is a list of some examples and the reference documentation of all available modules.

## Examples

- [Base Script](example/base_script.md)
- [Tasks](examples/tasks.md)

The BashLib contains some core functionality and optional modules which are listed below.

## Config

### Environment Module

The configuration module contains a lot of general configuration settings for the bash-lib modules itself. Most of them are specific to the individual environment so they need to be set in the local `overwrite` config.

| Variable/Function | Description |
| --- | --- |
| ``$MOUNT_COLOR_LIMIT`` | Array: Color limits per mount (pattern critical error warn ok) used in [`remote_df`](function/remote_df.md) |
| ``$MATTERMOST_API`` | Mattermost API url |
| ``$GRAFANA_API`` | Grafana API url |
| ``$CONFLUENCE_API`` | Atlassian confluence API url |
| ``$JIRA_API`` | Atlassian jira API url |
| ``$PROMETHEUS_API`` | Prometheus API urls |
| ``$PROMETHEUS`` | Prometheus host names |
| ``$CONFLUENCE_OUTAGE`` | Atlassian confluence page id for outage information |

## Core

### Config Module

shellcheck disable=SC2034

| Variable/Function | Description |
| --- | --- |
| ``$BASHLIB_HOME`` | Set in the environment to where the BASHLIB is installed |
| ``$CC_RESET`` | Reset all |
| ``$CC_CRITICAL`` | Set color for critical/disaster massages used by [`die`](function/die.md) |

### Function Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`input`](function/input.md) | Collect string from stdin (no parameters) or concatenate the parameters |
| [`input_args`](function/input_args.md) | Collect string from stdin (not more than defined parameters) or concatenate the parameters |
| [`input_lines`](function/input_lines.md) | Collect string from stdin (no parameters) or parameters each as a line |
| [`die`](function/die.md) | Output error message and exit |
| [`trap_add`](function/trap_add.md) | Set or add an additional trap without overwriting existing ones |
| [`trap_remove`](function/trap_remove.md) | Remove a specific trap |
| [`mktemp`](function/mktemp.md) | Make a temporary file, which is recognizable |
| [`option_parse`](function/option_parse.md) | Parse arguments based on given specification |
| [`option_help`](function/option_help.md) | Print help for options defined in options specification |

## Module

### Array Module

Array helpers.

| Variable/Function | Description |
| --- | --- |
| [`contains`](function/contains.md) | Check if value is contained in array |

### Atlassian Module

shellcheck source=config/environment

| Variable/Function | Description |
| --- | --- |
| [`confluence`](function/confluence.md) | Get page content from Confluence using API |
| [`jira_search`](function/jira_search.md) | Search for jira tickets |
| [`jira_get`](function/jira_get.md) | Get jira ticket details |
| [`jira_create`](function/jira_create.md) | Create jira tickets |
| [`jira_update`](function/jira_update.md) | Update jira tickets |

### Color Module

shellcheck disable=SC2034

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
| ``$CC_MAGENTA_BG`` | Set background color to magenat |
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
| ``$CC_INFO`` | Set color for highlighted information |
| ``$CC_OK`` | Set color for success messages |
| ``$CC_HEADING`` | Set color for block headings |
| ``$CC_INVERS`` | Set color for highlighted parts like table header |
| [`color_256`](function/color_256.md) | Get color code for text color number |
| [`color_256_bg`](function/color_256_bg.md) | Get color code for background color number |
| [`color_table`](function/color_table.md) | Show complete color table |

### Date Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`now`](function/now.md) | Get current timestamp |
| [`date_diff`](function/date_diff.md) | Calculate difference in seconds |
| [`date_format`](function/date_format.md) | Format date in different named versions or format string |

### File Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`script_path`](function/script_path.md) | Get the path from the called command |

### Input Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`pause`](function/pause.md) | Wait for user input |
| [`ask_no`](function/ask_no.md) | Ask yes/no with default: no |
| [`ask_yes`](function/ask_yes.md) | Ask yes/no with default: yes |
| [`ask_input`](function/ask_input.md) | Ask for a text line |
| [`choose`](function/choose.md) | Select from list (extended version of native select) |
| [`tasks`](function/tasks.md) | Run tasks as selected by user |

### Mattermost Module

shellcheck source=config/environment

| Variable/Function | Description |
| --- | --- |
| [`mattermost`](function/mattermost.md) | Send a message to Mattermost |
| [`mattermost_attachement`](function/mattermost_attachement.md) | Create an attachement json to be used in post |
| [`mattermost_reaction`](function/mattermost_reaction.md) | Add reaction to existing post |
| [`mattermost_repost`](function/mattermost_repost.md) | Add response to mattermost posting |

### Monitoring Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`exporter`](function/exporter.md) | Get exporter list |
| [`scrape`](function/scrape.md) | Scrape prometheus exporter url now |
| [`alerts`](function/alerts.md) | Get grafana alerts |
| [`prometheus`](function/prometheus.md) | Prom ql ausführen |
| [`prometheus_scrape`](function/prometheus_scrape.md) | Change scrape interval to scrape now and set back |

### Os Module

shellcheck disable=SC2034

| Variable/Function | Description |
| --- | --- |
| ``$OS`` | Operation System like: Linux, MacOS... (set in detect_os) |
| ``$KERNEL`` | Kernel version number (set in detect_os) |
| ``$MACH`` | CPU type (set in detect_os) |
| ``$DIST_BASE`` | Base distribution type like Debian (set in detect_os) |
| ``$DIST_BASE_REV`` | Base distributions number like 13 (set in detect_os) |
| ``$DIST`` | Distribution name like Ubuntu (set in detect_os) |
| ``$REV_NAME`` | Distributions revision name like noble (set in detect_os) |
| ``$REV`` | Distribution revision version number like 14.04 (set in detect_os) |
| ``$MACH_ID`` | CPU identifier (set in detect_os) |
| ``$IS_VIRTUAL`` | Is a virtual machine (set in detect_os) |
| ``$CPU_NUM`` | Number of CPU cores (set in detect_os) |
| ``$CPU_MODEL`` | CPU Model description (set in detect_os) |
| ``$IP_INTERN`` | Internal IP |
| ``$IP_EXTERN`` | External IP (set in detect_extern_ip) |
| ``$IP_COUNTRY`` | Country (set in detect_extern_ip) |
| ``$IP_COUNTRY_CODE`` | Country Code (set in detect_extern_ip) |
| ``$IP_REGION_CODE`` | Region Code (set in detect_extern_ip) |
| ``$IP_CITY`` | City (set in detect_extern_ip) |
| ``$IP_PROVIDER`` | Internet Provider (set in detect_extern_ip) |
| [`detect_os`](function/detect_os.md) | Run  os detection and set the constants |
| [`detect_extern_ip`](function/detect_extern_ip.md) | Run  os detection and set the constants |
| [`system_info`](function/system_info.md) | Display the system description |
| [`has_tty`](function/has_tty.md) | Has tty present |
| [`is_bash`](function/is_bash.md) | Is running with bash console |

### Output Module

shellcheck source=module/color

| Variable/Function | Description |
| --- | --- |
| [`help`](function/help.md) | Show help page and exit |
| [`heading`](function/heading.md) | Print block heading |
| [`critical`](function/critical.md) | Print critical/disaster message |
| [`error`](function/error.md) | Print error message |
| [`warn`](function/warn.md) | Print warning message |
| [`info`](function/info.md) | Print special information message |
| [`ok`](function/ok.md) | Print success message |
| [`invers`](function/invers.md) | Print special marked message like table header |
| [`color`](function/color.md) | Print message in defined color |
| [`debug`](function/debug.md) | Write message to STDERR if in DEBUG mode else do nothing |
| [`uncolorize`](function/uncolorize.md) | Remove color codes from text |
| [`html2md`](function/html2md.md) | Convert HTML to markdown (simplified version) |
| [`nocr`](function/nocr.md) | Remove carriage return from line endings |
| [`urlencode`](function/urlencode.md) | Encode message to be used within the url |
| [`tsv2table`](function/tsv2table.md) | Convert TSV data into visual table |
| [`tsv2md`](function/tsv2md.md) | Convert TSV data into markdown table |

### Process Module

Module for process control

| Variable/Function | Description |
| --- | --- |
| ``$STEPS_VARIABLES`` | Set the variables which should be stored with step control |
| ``$ASYNC_QUEUE_MAX`` | Maximum number of parallel tasks for queue |
| [`sudo_allow`](function/sudo_allow.md) | Check if sudo is needed for command |
| [`sudo`](function/sudo.md) | Sudo overwrite to only use sudo if needed |
| [`repeat`](function/repeat.md) | Execute command in N times |
| [`retry`](function/retry.md) | Retry a command multiple times until it succeeds |
| [`countdown`](function/countdown.md) | Sleep with countdown some seconds |
| [`lock`](function/lock.md) | Set a lock or wait till it can be set |
| [`lock_exit`](function/lock_exit.md) | Set the lock or exit with optional error message |
| [`unlock`](function/unlock.md) | Remove the lock |
| [`env_store`](function/env_store.md) | Store environment into shared memory/file |
| [`env_restore`](function/env_restore.md) | Restore environment from shared memory/file |
| [`env_clean`](function/env_clean.md) | Remove stored environment from shared memory/file |
| [`env_change`](function/env_change.md) | Change environment in shared memory/file |
| [`steps_init`](function/steps_init.md) | Initialize nstep control |
| [`steps_check`](function/steps_check.md) | Check if step already finished successful |
| [`steps_done`](function/steps_done.md) | Set step as successfully done |
| [`sync`](function/sync.md) | Run the given command with optional step control |
| [`sync_name`](function/sync_name.md) | Alternative to sync in which this call is given a name to refer |
| [`async`](function/async.md) | Run the given command asynchronous ang go on in the calling routine (short form of async_name) |
| [`async_name`](function/async_name.md) | Alternative to async in which this call is given a name to refer in async_wait |
| [`async_wait`](function/async_wait.md) | Check if the command is done or wait here till it is so |
| [`queue`](function/queue.md) | Add command to process queue |
| [`queue_name`](function/queue_name.md) | Add command to process queue |

### Remote Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| ``$CURL_HTTP_CODE`` | Last HTTP return code from curl |
| [`remote`](function/remote.md) | Run command on remote host |
| [`remote_term`](function/remote_term.md) | Run remote command with pseudo terminal |
| [`remote_term_line`](function/remote_term_line.md) | Run remote command with pseudo terminal but line based output (problematic with questions) |
| [`remote_file`](function/remote_file.md) | Run local script on remote |
| [`remote_console`](function/remote_console.md) | Open an interactive console on remote host |
| [`upload`](function/upload.md) | Upload file |
| [`download`](function/download.md) | Download file |
| [`remote_install`](function/remote_install.md) | Remote install package like @install |
| [`remote_df`](function/remote_df.md) | Remote df with visual display |
| [`remote_lvm`](function/remote_lvm.md) | Remote check if LVM is used |
| [`boot_wait`](function/boot_wait.md) | Wait till reboot is finished |
| [`curl`](function/curl.md) | Curl with added error handling |
| [`mongosh`](function/mongosh.md) | Run command on Mongo DB |

### Software Module

Software management functions.

| Variable/Function | Description |
| --- | --- |
| [`install`](function/install.md) | Install software package |
| [`semver`](function/semver.md) | Parse semantic version number |
| [`semver_diff`](function/semver_diff.md) | Calculate difference |

### Validator Module

Validators to make this easier and more readable.

| Variable/Function | Description |
| --- | --- |
| [`num_parameters`](function/num_parameters.md) | Check that a specific number of parameters are given |
| [`is_success`](function/is_success.md) | Test if given value is an exit/return success |
| [`is_empty`](function/is_empty.md) | Test if given value is an empty string or undefined |
| [`is_integer`](function/is_integer.md) | Test if given value is an integer |
| [`is_float`](function/is_float.md) | Test if given value is an float |
| [`trim_start`](function/trim_start.md) | Trim leading whitespace or given character |
| [`trim_end`](function/trim_end.md) | Trim trailing whitespace or given character |
| [`trim`](function/trim.md) | Trim leading and trailing whitespace or given character |

## Extra

### Divibib Module

shellcheck source=base

| Variable/Function | Description |
| --- | --- |
| [`confluence_outage`](function/confluence_outage.md) | Get outage information |
