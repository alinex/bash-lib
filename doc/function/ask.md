# ask

## Ask for an input element

This will also validate while typing if you select the correct format. So you can only input characters matching the input format.
Possible formats are:
- `string` - (default) allow anything
- `integer` or `number` - only allow [0-9]
- `float` - allow number [0-9]+.[0-9]+
- `password` - will show only `*` characters to hide input
Stdout:   `<answer>`


### Usage

```bash
ask <format> <question>
```

### Options

```bash
-e, --empty             # allowe empty value
-d, --default <value>   # set default if none given
-n, --allow-negative    # on number, integer, float
```

### TTY (direct)

```bash
<question> <valid characters>...
```
