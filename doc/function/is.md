# is

## Validate and sanitize values.

Every parameter should be checked to prevent failure later in the code. For such checks you run it with the `--die` option to stop processing if wrong.
But you can also use it in the program flow without that and use it's return status to check if it 0=ok or 1=failed.
The following checks are implemented:
- `set` will fail if no value given
- `empty` will fail if not empty like ""
- `bool` will transform the value to `1` or `0` and allows: true/false, t/f, 1/0, yes/no, y/j/n, ja/nein, ""
- `integer` will check for a number maybe within a range
- `float` will check for a number maybe within a range
Exit:     with message if incorrect value


### Usage

```bash
is <check> <value> [options]
```

### Options

```bash
d, die              # stop with error instead of return state
n, name=<string>    # name the variable for the `die` message
s, sanitize         # for integer
min=<num>           # for integer
max=<num>           # for integer
```

### Output (stdout)

- `<value>`             # may be sanitized

### Examples

- # check arguments
- is --name=arguments integer $# --min=1 --max=2
- name="$(is --name=age integer "`$1`" --sanitize --min=0)"
- init="$(is --name=init bool "`$1`")"
- # use in code
- if is integer age --min=18; then
