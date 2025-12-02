# log

## Additional logging (at the moment only into files).

After initialising a log using `start` the default output options will additionally write into log. But you can also specifically write t it using the log function.
Multiple log with different levels are possible.


### Usage

```bash
log start <file>        # no spaces in file path allowed
log <level> <message>
log end <file>
```

### Options

```bash
-l, --level=<level>                 # level := debug info notice warn error critical
# File logging:
-r, --rotate=hourly|daily|weekly|monthly|<bytes>
-c, --cleanup=<num>|<duration>
-z, --compress
```

### Files

- `<file>`[_`<pattern>`]                  # will contain the logs

### Examples

- # Format: `<date>` `<time>` `<level>` `<message>`
- 2025-12-02 14:07:35 INFO Hello
- 2025-12-02 14:10:04 ERROR Thius is only a test
