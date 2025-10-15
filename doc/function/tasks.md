# tasks

## Run tasks as selected by user

Often the functions are also named `check-...` for the ones which will return tasks and `task-...` for the ones really doing the job. The first one may do a lot of analyzation and output user information on stdout.
The '|' character is not possible within the commans. If a pipe is neccessary put it within a function. Also some commands can be disabled in the list by preceding the command with an `#` character.
Option    -t, --title `<title>`             # display text line above selection


### Usage

```bash
tasks <entry>...
# <entry>       := <check-fn> or "<task-line>"
# <check-fn>    := function called to return up to multiple <task-lines>
# <task-fn>     := function to be run when selected
# <task-line>   := "<task-fn> | <name>"
<task-lines> | tasks            # entries from pipe
tasks <check-fn>                # add entries from function (dynamic)
-d, --default <task-fn> | "x"   # default command to start
```

### TTY (direct)

```bash
[<title>]
1) <name>
...
x) Beenden
<question> <input>
```

### Examples

- list_tasks() {
- # can be created dynamically:
- cat `<`<'EOC'
- task_analyze    | Disk Analyze
- task_apt        | APT cleanup (15 kB)
- EOC
- }
- task_analyze() {
- heading Analyze
- }
- task_apt() {
- heading APT Cleanup
- }
- tasks -t "Nächste Schritte" list_tasks
