# Shared Memory

The use of shared memory is very simple through BashLib. Here we show some usage examples for it.

Shared memory is used in Bash like access to files. Therefore the device `/dev/shm` is your shared memory which you can access. Using BashLib it is best to do so with the [`mktemp -m`](../function/mktemp.md) command which will create the file including the program name.

## Real Global Variables

Because in Bash variables can only be global to the current process, you may get a copy of them in sub shells. This means you have the variable and can work on it but if you change it you won't see the change in the parent function. An example which won't work is:

```bash
$ default="init"
$ set_default() { 
    default="$1"
  }

# direct call will work
$ set_default one
$ echo $default
one

# running in a subshell won't change it
$ $(set_default two)
$ echo $default
one
```

To overcome this you have to return the value using `echo` and set it to the variable in the calling function or use a global store like shared memory:

```bash
# initialisieren
$ default="init"
env_store task default # store only default variable

# verändern
$ set_default() { 
    default="$1"
    env_store task default # store only default variable
  }

default="task_increase $device"
env_restore task # all that is contained

# running in a subshell
$(set_default two)
env_restore task
echo $default
two

# cleanup
env_clean task
```

> In the above example the variable `default` will be stored in `/dev/shm/<prog>_task.env` every time it is read it should be loaded using [env_restore](../function/env_restore.md) and after changing it updated using [env_store](../function/env_store.md). At the end a cleanup can be done using [env_clean](../function/env_clean.md).
