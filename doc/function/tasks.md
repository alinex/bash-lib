# tasks

## Run tasks as selected by user

### Usage

```bash
tasks <entry>...
# <entry>       := <check-fn> or "<task-line>"
# <check-fn>    := function called to return up to multiple <task-lines>
# <task-fn>     := function to be run when selected
# <task-line>   := "<task-fn> | <name>"
<task-lines> | tasks            # entries from pipe
tasks <check-fn>                # add entries from function (dynamic)
d, default <string|int|variable>  # default command to start
T, timeout <sec>             # timeout till default selection
```

### Files

- `/dev/shm/<program>_tasks_<pid>` will be used while dynamically generating the tasks list and removed afterwards

### TTY (direct)

Nächste Schritte
   1) Analyse einzelner Partitionen
   2) Docker aufräumen mit etwa 206MB unter /data
   3) Remote Host Console (interaktiv)
   x) Beenden
Wähle eine der obigen Optionen: [1]

### Examples

[`tasks`](../example/tasks.md) different possibilities


### Description


Often the functions are also named `check-...` for the ones which will return tasks and `task-...` for the ones really doing the job. The first one may do a lot of analyzation and output user information on stdout.
The '|' character is not possible within the commands. If a pipe is necessary put it within a function. Also some commands can be disabled in the list by preceding the command with an `#` character.

If there are no tasks defined or the dynamic list will return no tasks it will end with a success message.

Option    t, title `<title>`             # display text line above selection
