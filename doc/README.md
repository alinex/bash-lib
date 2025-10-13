# BashLib Modules


## Examples

- [Base Script](example/base_script.md)

The BashLib contains some core functionality and optional modules which are listed below.

## Core

### [/home/alex/dvb/scripts/local/bashlib/core/1_color Module](./1_color.md)

This module contains color specifications to be used in console output.

| Variable/Function     | Description                                               |
| --------------------- | --------------------------------------------------------- |
| `$COLORS`             | Number of colors possible on terminal                     |
| `$CC_RESET`           | Reset all                                                 |
| `$CC_RESET_FG`        | Reset text color                                          |
| `$CC_RESET_BG`        | Reset background color                                    |
| `$CC_INTENSITY_BOLD`  | Set intensity to bold                                     |
| `$CC_INTENSITY_LIGHT` | Set intensity to light                                    |
| `$CC_INTENSITY_OFF`   | Set intensity back to normal                              |
| `$CC_ITALIC`          | Set italic mode                                           |
| `$CC_ITALIC_OFF`      | Unset italic mode                                         |
| `$CC_UNDERLINE`       | Set underline mode                                        |
| `$CC_UNDERLINE_OFF`   | Unset underline mode                                      |
| `$CC_INVERSE`         | Set inverse mode (change text color and background color) |
| `$CC_INVERSE_OFF`     | Unset inverse mode                                        |
| `$CC_DASHED`          | Set strike through mode                                   |
| `$CC_DASHED_OFF`      | Unset strike through mode                                 |
| `$CC_BLACK`           | Set text color to black                                   |
| `$CC_RED`             | Set text color to red                                     |
| `$CC_GREEN`           | Set text color to green                                   |
| `$CC_YELLOW`          | Set text color to yellow                                  |
| `$CC_BLUE`            | Set text color to blue                                    |
| `$CC_MAGENTA`         | Set text color to magenta                                 |
| `$CC_CYAN`            | Set text color to cyan                                    |
| `$CC_WHITE`           | Set text color to white                                   |
| `$CC_BLACK_BOLD`      | Set text color to bold black                              |
| `$CC_RED_BOLD`        | Set text color to bold red                                |
| `$CC_GREEN_BOLD`      | Set text color to bold green                              |
| `$CC_YELLOW_BOLD`     | Set text color to bold yellow                             |
| `$CC_BLUE_BOLD`       | Set text color to bold blue                               |
| `$CC_MAGENTA_BOLD`    | Set text color to bold magenta                            |
| `$CC_CYAN_BOLD`       | Set text color to bold cyan                               |
| `$CC_WHITE_BOLD`      | Set text color to gray                                    |
| `$CC_BLACK_BG`        | Set background color to black                             |
| `$CC_RED_BG`          | Set background color to red                               |
| `$CC_GREEN_BG`        | Set background color to green                             |
| `$CC_YELLOW_BG`       | Set background color to yellow                            |
| `$CC_BLUE_BG`         | Set background color to blue                              |
| `$CC_MAGENTA_BG`      | Set background color to magenat                           |
| `$CC_CYAN_BG`         | Set background color to white                             |
| `$CC_BLACK_BOLD_BG`   | Set background color to bold black                        |
| `$CC_RED_BOLD_BG`     | Set background color to bold red                          |
| `$CC_GREEN_BOLD_BG`   | Set background color to bold green                        |
| `$CC_YELLOW_BOLD_BG`  | Set background color to bold yellow                       |
| `$CC_BLUE_BOLD_BG`    | Set background color to bold blue                         |
| `$CC_MAGENTA_BOLD_BG` | Set background color to bold magenta                      |
| `$CC_CYAN_BOLD_BG`    | Set background color to bold cyan                         |
| `$CC_CRITICAL`        | Set color for critical/disaster massages                  |
| `$CC_ERROR`           | Set color for error messages and failures                 |
| `$CC_WARN`            | Set color for warnings                                    |
| `$CC_INFO`            | Set color for highlighted information                     |
| `$CC_OK`              | Set color for success messages                            |
| `$CC_HEADING`         | Set color for block headings                              |
| `$CC_INVERS`          | Set color for highlighted parts like table header         |
| `color_256`           | Get color code for text color number                      |
| `color_256_bg`        | Get color code for background color number                |
| `color_table`         | Show complete color table                                 |

### [/home/alex/dvb/scripts/local/bashlib/core/2_core Module](./2_core.md)

The core module contains essential parts which may also be used while loading the library.

| Variable/Function | Description                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| `$BASHLIB_BASE`   | Path to the directory in which the bash-lib is                             |
| `input`           | If stdin and no parameters then read stdin, else use parameters            |
| `input_args`      | If stdin and not more than defined parameters, then read stdin             |
| `input_lines`     | Read stdin and no parameters then read stdin, else use parameters as lines |
| `die`             | Output error and exit                                                      |
| `trap_add`        | Set or add an additiopnal trap without overwriting existing ones           |
| `trap_remove`     | Remove a specific trap                                                     |
| `mktemp`          | Make a temporary file, which is recognizable                               |
| `option_parse`    | Parse arguments based on given specification                               |
| `option_help`     | Print help for options defined in options specification                    |
| `help`            | Show help page and exit                                                    |

## Module

### [/home/alex/dvb/scripts/local/bashlib/module/array Module](./array.md)

Array helpers.

| Variable/Function | Description                 |
| ----------------- | --------------------------- |
| `contains`        | Check if value is contained |

### [/home/alex/dvb/scripts/local/bashlib/module/atlassian Module](./atlassian.md)

This covers atlassian API for Jira and confluence.

| Variable/Function | Description                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| `jira_search`     | https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#version |

### [/home/alex/dvb/scripts/local/bashlib/module/date Module](./date.md)

Some helpers to work easier with dates.

| Variable/Function | Description                                               |
| ----------------- | --------------------------------------------------------- |
| `now`             | Get current timestamp                                     |
| `date_diff`       | Calculate difference in seconds                           |
| `date_format`     | Format date in different nnamed versions or format string |

### [/home/alex/dvb/scripts/local/bashlib/module/divibib Module](./divibib.md)

Module with divibib specific helpers.

| Variable/Function | Description |
| ----------------- | ----------- |

### [/home/alex/dvb/scripts/local/bashlib/module/mattermost Module](./mattermost.md)

Using the mattermost API to write messages.

| Variable/Function        | Description                                   |
| ------------------------ | --------------------------------------------- |
| `mattermost`             | Send a message to Mattermost                  |
| `mattermost_attachement` | Create an attachement json to be used in post |
| `mattermost_reaction`    | Add reaction to existing post                 |
| `mattermost_repost`      | Add response to mattermost posting            |

### [/home/alex/dvb/scripts/local/bashlib/module/monitoring Module](./monitoring.md)

Using the Grafana/Prometheus APIs to get Monitoring information.

| Variable/Function   | Description                                       |
| ------------------- | ------------------------------------------------- |
| `exporter`          | Get exporter list                                 |
| `scrape`            | Scrape prometheus exporter url now                |
| `alerts`            | Get grafana alerts                                |
| `prometheus`        | Prom ql ausführen                                 |
| `prometheus_scrape` | Change scrape interval to scrape now and set back |

### [/home/alex/dvb/scripts/local/bashlib/module/os Module](./os.md)

Module with operating system specific helper functions.

| Variable/Function  | Description                                                        |
| ------------------ | ------------------------------------------------------------------ |
| `$OS`              | Operation System like: Linux, MacOS... (set in detect_os)          |
| `$KERNEL`          | Kernel version number (set in detect_os)                           |
| `$MACH`            | CPU type (set in detect_os)                                        |
| `$DIST_BASE`       | Base distribution type like Debian (set in detect_os)              |
| `$DIST_BASE_REV`   | Base distributions number like 13 (set in detect_os)               |
| `$DIST`            | Distribution name like Ubuntu (set in detect_os)                   |
| `$REV_NAME`        | Distributions revision name like noble (set in detect_os)          |
| `$REV`             | Distribution revision version number like 14.04 (set in detect_os) |
| `$MACH_ID`         | CPU identifier (set in detect_os)                                  |
| `$IS_VIRTUAL`      | Is a virtual machine (set in detect_os)                            |
| `$CPU_NUM`         | Number of CPU cores (set in detect_os)                             |
| `$CPU_MODEL`       | CPU Model description (set in detect_os)                           |
| `$IP_INTERN`       | Internal IP                                                        |
| `$IP_EXTERN`       | External IP (set in detect_extern_ip)                              |
| `$IP_COUNTRY`      | Country (set in detect_extern_ip)                                  |
| `$IP_COUNTRY_CODE` | Country Code (set in detect_extern_ip)                             |
| `$IP_REGION_CODE`  | Region Code (set in detect_extern_ip)                              |
| `$IP_CITY`         | City (set in detect_extern_ip)                                     |
| `$IP_PROVIDER`     | Internet Provider (set in detect_extern_ip)                        |
| `detect_os`        | Run  os detection and set the constants                            |
| `detect_extern_ip` | Run  os detection and set the constants                            |
| `system_info`      | Display the system description                                     |
| `has_tty`          | Has tty present                                                    |
| `is_bash`          | Is running with bash console                                       |

### [/home/alex/dvb/scripts/local/bashlib/module/output Module](./output.md)

Module with output and user interaction helpers.

| Variable/Function | Description                                              |
| ----------------- | -------------------------------------------------------- |
| `heading`         | Print block heading                                      |
| `critical`        | Print critical/disaster message                          |
| `error`           | Print error message                                      |
| `warn`            | Print warning message                                    |
| `info`            | Print special information message                        |
| `ok`              | Print success message                                    |
| `invers`          | Print special marked message like table header           |
| `color`           | Print message in defined color                           |
| `debug`           | Write message to STDERR if in DEBUG mode else do nothing |
| `uncolorize`      | Remove color codes from text                             |
| `html2md`         | Convert HTML to markdown (simplified version)            |
| `nocr`            | Remove carriage return from line endings                 |
| `urlencode`       | Encode message to be used within the url                 |
| `tsv2table`       | Convert TSV data into visual table                       |
| `tsv2md`          | Convert TSV data into markdown table                     |
| `pause`           | Wait for user input                                      |
| `ask_no`          | Ask yes/no with default: no                              |
| `ask_yes`         | Ask yes/no with default: yes                             |
| `ask_input`       | Ask for a text line                                      |
| `choose`          | Select from list (extended version of native select)     |
| `tasks`           | Run tasks as selected by user                            |

### [/home/alex/dvb/scripts/local/bashlib/module/process Module](./process.md)

Module for process control

| Variable/Function  | Description                                                                                    |
| ------------------ | ---------------------------------------------------------------------------------------------- |
| `$STEPS_VARIABLES` | Set the variables which should be stored with step control                                     |
| `$ASYNC_QUEUE_MAX` | Maximum number of parallel tasks for queue                                                     |
| `repeat`           | Execute command in N times                                                                     |
| `countdown`        | Sleep with countdown some seconds                                                              |
| `lock`             | Set a lock or wait till it can be set                                                          |
| `lock_exit`        | Set the lock or exit with optional error message                                               |
| `unlock`           | Remove the lock                                                                                |
| `env_store`        | Store environment into shared memory/file                                                      |
| `env_restore`      | Restore environment from shared memory/file                                                    |
| `env_clean`        | Remove stored environment from shared memory/file                                              |
| `env_change`       | Change environment in shared memory/file                                                       |
| `steps_init`       | Initialize nstep control                                                                       |
| `steps_check`      | Check if step already finished successfull                                                     |
| `steps_done`       | Set step as successfully done                                                                  |
| `sync`             | Run the given command with optional step control                                               |
| `sync_name`        | Alternative to sync in which this call is given a name to refer                                |
| `async`            | Run the given command asynchronous ang go on in the calling routine (short form of async_name) |
| `async_name`       | Alternative to async in which this call is given a name to refer in async_wait                 |
| `async_wait`       | Check if the command is done or wait here till it is so                                        |
| `queue`            | Add command to process queue                                                                   |
| `queue_name`       | Add command to process queue                                                                   |

### [/home/alex/dvb/scripts/local/bashlib/module/remote Module](./remote.md)

Module with remote calling/execution helpers.

| Variable/Function  | Description                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------ |
| `$CURL_HTTP_CODE`  | Last HTTP return code from curl                                                            |
| `remote`           | Run command on remote host                                                                 |
| `remote_term`      | Run remote command with pseudo terminal                                                    |
| `remote_term_line` | Run remote command with pseudo terminal but line based output (problematic with questions) |
| `remote_file`      | Run local script on remote                                                                 |
| `upload`           | Upload file                                                                                |
| `download`         | Download file                                                                              |
| `remote_install`   | Remote install package                                                                     |
| `remote_df`        | Remote df with visual display                                                              |
| `remote_lvm`       | Remote check if LVM is used                                                                |
| `boot_wait`        | Wait till reboot is finished                                                               |
| `curl`             | Curl with added error handling                                                             |
| `mongosh`          | Run command on Mongo DB                                                                    |

### [/home/alex/dvb/scripts/local/bashlib/module/software Module](./software.md)

Software management functions.

| Variable/Function | Description                   |
| ----------------- | ----------------------------- |
| `install`         | Install software package      |
| `semver`          | Parse semantic version number |
| `semver_diff`     | Calculate difference          |

### [/home/alex/dvb/scripts/local/bashlib/module/validator Module](./validator.md)

Validators to make this easier and more readable.

| Variable/Function | Description                                                 |
| ----------------- | ----------------------------------------------------------- |
| `num_parameters`  | Check that a specific number of parameters are given        |
| `is_success`      | Test if given value is an exit/return success               |
| `is_empty`        | Test if given value is an empty string or undefined         |
| `is_integer`      | Test if given value is an integer                           |
| `is_float`        | Test if given value is an float                             |
| `compare`         | Compare two values (simplification of different bash tests) |
| `trim_start`      | Trim leading whitespace or given character                  |
| `trim_end`        | Trim trailing whitespace or given character                 |
| `trim`            | Trim leading and trailing whitespace or given character     |
