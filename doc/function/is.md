# is

## Validate and sanitize values.

This validation is possible using the [`check`](check.md) and `is` function.
- [`check`](check.md) should be used for sanitize because it will output the value
- `is` should be used for checking only validity or stop processing on problem because no value is output

Every parameter should be checked to prevent failure later in the code.
For such checks you run it with the `--die` option to stop processing if wrong.
But you can also use it in the program flow without that and use it's return status to check if it 0=ok or 1=failed.

Because the values may start with an dash you should always put it at the end after '--' to prevent parsing it as option.

The following checks are implemented:

- `set` will fail if no value given
- `empty` will fail if not empty like ""
- `bool` will transform the value to `1` or `0` and allows: true/false, t/f, 1/0, yes/no, y/j/n, ja/nein, ""
- `integer` will check for a number maybe within a range
- `float` will check for a number maybe within a range
- `enum' will check against valid words using `--allow="word1 word2"``
- `length` check that the length is within range (like integer)
- `duration` check and parse the [`duration_format`](duration_format.md)

Exit:     with message if incorrect value

### Usage

```bash
is <check> [options] -- <value>
```

### Options

```bash
d, die              # stop with error instead of return state
n, name=<string>    # name the variable for the `die` message
min=<num>           # for integer
max=<num>           # for integer
allow=<words>       # for enum (space separated)
```

### Examples

Check arguments:

- `is integer --name=arguments --max=2 $#` # mostly only check max, if all args are checked separately

Use in code:

- `if is integer age --min=18 -- "`$1`"; then ...`
- `if ! is integer "`$DEBUG`"; then ...`

