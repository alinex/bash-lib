# Log Handler

A handler to write logs with an easy to use logging library that can be sourced from scripts.
It allows logging to an arbitrary file, to `STDERR`, or to a syslog facility. It supports eight logging levels.

## Basic Usage

First you should setup the logging process using:

```bash
LOG_LEVEL='INFO'                    # minimum log level
# use one of the following
LOG_FILE='STDERR'                   # output to STDERR
LOG_FILE='/var/log/myscript.log'    # output in file
SYSLOG_FACILITY='local7'            # output to syslog
# optional
LOG_DATE_FORMAT="+%Y-%m-%d %H:%M:%S"
```

Now include this library which will also include the colors library:

```bash
source ../bash-lib/log.bash  # log handler
```

After that messages may be invoked easily using:

```bash
log INFO "process is working"
log_exit EMERG "preprocessing not done, stopping" 16
```

While the first call will only output the log message, the second call also exits the running program with the additionally given exit code.

## Piping messages

But you can also pipe output from other commands directly to the log:

```bash
run-process | log INFO # log stdin
run-process 2>&1 >/dev/null | log ERROR # log stderr
run-process |& log INFO # log stdin + stderr
( run-process | log INFO ) 3>&1 1>&2 2>&3 | log ERROR # log both differently
( run-process 3>&1 1>&2 2>&3 | log ERROR ) 3>&1 1>&2 2>&3 | log INFO # priorize INFO
```

The last lines shows how to flip `STDOUT` and `STDERR` as pipe works on file descriptor one only.

Often useful in pipes but also usable in other log messages is the special `AUTO` log setting:

```bash
run-process |& log AUTO
```

This will auto detect the concrete log level for each line. Currently `DEBUG`, `INFO`, `NOTICE`, `WARN`, `WARNING`, `ERR`, `ERROR`, `CRIT`, `CRITICAL`, `ALERT`, `EMERG` and `EMERGENCY` will trigger the specified log type. All other lines are output as `INFO` type.

The concrete rules for auto detection may be further optimized in the future...

## Log Levels

Eight logging levels are supported, combining the levels from the Python logging module and RFC 5424.

| Level              | Numeric value | Syslog numerical code | Origin              |
| ------------------ | ------------- | --------------------- | ------------------- |
| DEBUG              | 10            | 7                     | Python and RFC 5424 |
| INFO               | 20            | 6                     | Python and RFC 5424 |
| NOTICE             | 25            | 5                     | RFC 5424 specific   |
| WARN or WARNING    | 30            | 4                     | Python and RFC 5424 |
| ERR or ERROR       | 40            | 3                     | Python and RFC 5424 |
| CRIT or CRITICAL   | 50            | 2                     | Python and RFC 5424 |
| ALERT              | 60            | 1                     | RFC 5424 specific   |
| EMERG or EMERGENCY | 70            | 0                     | RFC 5424 specific   |

Setting the `LOG_LEVEL` in the script will log subsequent log messages at that value or higher only.
The `LOG_LEVEL` may be changed anytime within the script.

## File rotation

This can be established using `logrotate` but you may also use the included mechanism by setting it up before you include the library. If you go with logrotate you don't need to restart or change anything because no filehandle is kept open.

### Rotate by date

```bash
LOG_ROTATE_TIME=DAILY   # date as YYYY-MM-DD
LOG_ROTATE_TIME=WEEKLY  # date as YYYY_week_WW
LOG_ROTATE_TIME=MONTHLY # date as YYYY-MM
```

If this is set the current logs will go in the normal log file but on a new day the old file will be renamed with it's date pattern appended.

The rotated files may also be compressed by setting the `LOG_ROTATE_GZP` flag.

### Rotate by size

To rotate on fixed file size use:

```bash
LOG_ROTATE_SIZE=<bytes>
LOG_ROTATE_NUM=<max number of files>
```

But you can't combine the two rotation methods, currently.
