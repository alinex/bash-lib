# tasks

## Run tasks as selected by user

Option    -t, --title `<title>`             # display text line above selection
TTY:      [`<title>`]


### Usage

```bash
tasks <function>"|"<entry>"...  # entries from arguments
<list> | tasks                  # entries from ppe
tasks <function>                # entries from function (dynamic)
<list>
...
<question> <key>
```

### Example

```bash
list_tasks() {
# can be created dynamically:
cat <<'EOC'
task_analyze    | Disk Analyze
task_apt        | APT cleanup (15 kB)
EOC
}
task_analyze() {
heading Analyze
}
task_apt() {
heading APT Cleanup
}
tasks -t "Nächste Schritte" list_tasks
```
