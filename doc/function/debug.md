# debug

## Write message to STDERR if in DEBUG mode else do nothing

Debug can support multiple levels starting from 1 upwards to be more verbose. This will only be shown if environment variable `DEBUG` is the same number or higher.
Stderr:   gray `<string>`


### Usage

```bash
debug [<num>] <message>
<message> | debug [<num>]
    <num> := [1-9]  # (default 1) higher to only show in more verbose call
    <message>       # the message text optimal only one line (multiple calls possible)
```
