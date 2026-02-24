# is

## Validate and sanitize values.

### Usage

```bash
is <check> [options] -- <value>
```

### Options

```bash
# general options
-d, --die                       # used in [`is`](is.md) to stop with error instead of return state
-o, --output=[<variable-name>]  # will write the sanitized value into variable or output it to stdout
-n, --name=<string>             # used in [`is`](is.md) to display variable name in `die` message
-m, --message=<string>          # additional message like usage
# for integer
-s, --sanitize                  # remove invalid characters
--min=<num>                     # minimum number allowed
--max=<num>                     # maximum number allowed
# enum/url
--allow=<words>                 # space separated (protocol in url)
# domain
--exists                        # domain can be resolved
# ipv4
--private                       # only private addresses
--public                        # only public addresses
--loopback                      # only local loopback addresses
--range <network-range>         # ip is within netmask (multiple allowed)
--ping                          # check that ping is possible
--no-ping                       # ping should not be possible
# url
--exists                        # url is reachable
--ok                            # url has code 2xx
```

### Output (stdout)

`<value>`                         # may be sanitized

### Examples

- [`is`](../example/is.md) explains some regular use cases
- `is integer --name=arguments --max=2 -- $# >/dev/null` # mostly only check max, if all args are checked separately
- `name="$(is integer --name=age --sanitize --min=0 --output -- "`$1`")"`
- `is integer --name=age --sanitize --min=0 --output=name -- "`$1`"`
- `init="$(is bool --name=init --output -- "`$1`")"`
- `if is integer age --min=18 -- "`$1`"; then`


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
- `time` check that the input is a valid time format
- `duration` check and parse the [`duration_format`](duration_format.md)
- `path` check that value is an existing path (any type)
- `file` check that value is an existing file
- `directory` check that value is an existing directory
- `readable` check that value is a file readable by user
- `writable` check that value is a file writable by user
- `domain` check for a domain name (part of the url)
- `ipv4` ip address check
- `url` check that it is a full url

Exit:     with message if incorrect value
