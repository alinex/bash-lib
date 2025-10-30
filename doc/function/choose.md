# choose

## Select from list (extended version of native select)

Entry:    `<entry>` := `<string>` | `<key>` "|" `<display>` # whitespace arround values are removed
Stdout:   selected `<line>`
TODO >` 10 entries make two columns using mlr display


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

```bash
[<title>]
<list>
...
<question> <key>
exit # if run with --exit and this was choosen
```
