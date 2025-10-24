# debug

## Write message to STDERR if in DEBUG mode else do nothing

Debug can support multiple levels starting from 1 upwards to be more verbose. This will only be shown if environment variable `DEBUG` is the same number or higher. Or if the `DEBUG` variable includes the function name. Multiple lines will be printed seperately to have the function name prefix at the start of each.
Stderr:   >` `<func>`           `<message>`      # color: gray


### Usage

```bash
debug [<num>] <message>
<message> | debug [<num>]
    <num> := [1-9]      # (default 1) higher to only show in more verbose call
    <message>           # the message text
```

### Globals

- `$DEBUG` - if unset nothing will be printed
- `$DEBUG`=`<num>` - only print messages with same or lower numeric level
- `$DEBUG`=`<func>`,... - only print if the function is matched
- `$DEBUG`=9 - to output all
