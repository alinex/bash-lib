# check

## Validate and sanitize values.

### Usage

```bash
check <check> [options] -- <value>
```

### Options

```bash
d, die              # used in [`is`](is.md) to stop with error instead of return state
n, name=<string>    # used in [`is`](is.md) to display variable name in `die` message
s, sanitize         # for integer
min=<num>           # for integer
max=<num>           # for integer
allow=<words>       # for enum (space separated)
```

### Output (stdout)

`<value>`             # may be sanitized

### Examples

Check arguments:

- `check integer --name=arguments --max=2 -- $# >/dev/null` # mostly only check max, if all args are checked separately
- `name="$(check integer --name=age --sanitize --min=0 -- "`$1`")"`
- `init="$(check bool --name=init "`$1`")"`

Use in code:

- `if check integer age --min=18 -- "`$1`" >/dev/null; then`


### Description


This validation is possible using the `check` and [`is`](is.md) function.
- `check` should be used for sanitize because it will output the value
- [`is`](is.md) should be used for checking only validity or stop processing on problem because no value is output

Every parameter should be checked to prevent failure later in the code.
For such checks you run it with the `--die` option to stop processing if wrong.
But you can also use it in the program flow without that and use it's return status to check if it 0=ok or 1=failed.

Because the values may start with an dash you should always put it at the end after '--' to prevent parsing it as option.

The following checks are implemented:

- `set` will fail if no value given
- `empty` will fail if not empty like ""
- `bool` will transform the value to `1` or `0` and allows: true/false, t/f, 1/0, yes/no, y/j/n, ja/nein, ""
- `true` should be a boolean true
- `false` should be a boolean false
- `integer` will check for a number maybe within a range
- `float` will check for a number maybe within a range
- `enum' will check against valid words using `--allow="word1 word2"``
- `length` check that the length is within range (like integer)
- `date` check that the input is parsable as date and return unix timestamp
- `duration` check and parse the [`duration_format`](duration_format.md)
- `path` check that value is an existing path (any type)
- `file` check that value is an existing file
- `directory` check that value is an existing directory
- `readable` check that value is a file readable by user
- `writable` check that value is a file writable by user

Exit:     with message if incorrect value
