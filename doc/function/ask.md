# ask

## Ask for an input element

### Usage

```bash
ask <format> <question>
```

### Options

```bash
e, empty                 # allow empty value
n, allow-negative        # on number, integer, float
d, default <value>       # set default if none given
T, timeout <duration>    # time till default is used
```

### TTY (direct)

```bash
<question> <valid characters>...
# input <keys> printed if valid
```

### Output (stdout)

`<answer>`

### Examples

[`input`](../example/input.md#ask) shows all possible use cases


### Description

This will also validate while typing if you select the correct format. So you can only input characters matching the input format.
Possible formats are:

- `string` - (default) allow anything
- `text` - multiline text (ends with empty line)
- `editor` - multiline text through system editor
- `integer` or `number` - only allow [0-9]
- `float` - allow number [0-9]+.[0-9]+ (alternative , is allowed as decimal separator)
- `password` - will show only `*` characters to hide input
- `time` - a time with hour and minute can be given

If another format is needed, you can fall back to string and validate on your own after you got the response.
