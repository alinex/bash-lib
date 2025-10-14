# choose

## Select from list (extended version of native select)

Option    -t, --title `<title>`         # display text line above selection
Entry:    `<entry>` := `<string>` | `<key>` "|" `<display>` # whitespace arround values are removed
TTY:      [`<title>`]
Stdout:   selected `<line>`
TODO >` 10 entries make two columns using mlr display


### Usage

```bash
choose [-t] <entry>...
<list> | choose [-t]
-x, --exit <string>         # will add an exit option at the end -> return "exit"
-d, --default <string|int>  # the command or number which will be returned on <enter>
<list>
...
<question> <key>
```
