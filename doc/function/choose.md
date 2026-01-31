# choose

## Select from list (extended version of native select)

### Usage

```bash
choose [-t] <entry>...
<list> | choose [-t]
```

### Options

```bash
-t, --title <title>         # display text line above selection
-x, --exit <string>         # will add an exit option at the end -> return "exit"
-d, --default <string|int>  # the command or number which will be returned on <enter>
-T, --timeout <duration>    # timeout till default selection as seconds or duration [`duration_format`](duration_format.md)
```

### TTY (direct)


```
[<title>]
<list>
...
<question> <key>
```

### Output (stdout)

selected `<line>`

### Return (exit code)

- `exit 0` # if run with `--exit` and this was chosen

### Examples

[`input`](../example/input.md#choose) shows all possible use cases


### Description


The given list will be printed as numerical options from which you select one by typing it's number. Number validation is on, so you can only input a valid number. No return-key needed if the full number is given.
Each list entry can be a single `<text>` or `<key>|<name>` while the `<name>` is shown the `<key>` will be returned if selected.

With the options a default can be given, which will be selected using return-key or a timeout till this is used.
With the option `--exit` the additional entry will break by returning `exit`.

Entry:    `<entry>` := `<string>` | `<key>` "|" `<display>` # whitespace around values are removed
