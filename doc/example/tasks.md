# Tasks

The tasks function gives you the possibility to give the user an endless selection of different tasks from which he could select. It has an extra option to exit.

We only show the part of the script which will do the tasks, see [Base Script](./base_script.md) for the start of the script.

## Fixed Task List

First a simple and fixed task list:

```bash
task_one() {
    echo "Running task one"
}
task_two() {
    echo "Running task two"
}
task_three() {
    echo "Running task three"
}

echo "
task_one   | First Task
task_two   | Second Task
task_three | Third Task
" | tasks -t "Next step"
```

## Dynamic Entries

Next you can call a function which let's you dynamically define which tasks should be available.

```bash
list_tasks() {
    echo "task_one|Fist Task"
    if [ ... ] then
        echo "task_two|Second Task"
    fi
}
task_one() {
    echo "Running task one"
}
task_two() {
    echo "Running task two"
}

heading Test
tasks -t "Nächste Schritte" list_tasks
```

And you can also mix dynamic detection and fixed calls.

```bash
check_one() {
    echo "task_one|Fist Task"
}
task_one() {
    echo "Running task one"
}
check_two() {
    # this is a message to the user displayed above 
    # the selection in each round
    echo "We have..." >&2 
    if [ ... ] then
        echo "task_two|Second Task"
    fi
}
task_two() {
    echo "Running task two"
}

heading Test
echo "
check_one
check_two
#check_three
remote_console | Open Remote Console (interactive)
" | tasks -t "Nächste Schritte" -d task_one
```

## Dynamic Default Setting

The functions which generate the dynamic options can also dynamically evaluate the default option. Therefore a Shared Memory Segment with name `${$}_tasks` is used.
This gives an unique name for the current script run.

```bash
# initialize
default=""
env_store "${$}_task" default

list_xxx() {
    ...
    default="task_one"
    env_store "${$}_task" default
}
```

That's all, the [`tasks`](../function/tasks.md) function will read it if there and also remove it if the task loop is normally exited.
