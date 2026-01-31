# variables

## Store variables into shared memory/file

### Usage

```bash
variables store [<ident>] [<variable>]...   # store complete or only listed variables (ident can be empty string)
variables restore [<ident>] [<variable>]... # restore all or defined variables
variables clean [<ident>]                   # remove the store
variables update <ident> <cmd-line> [<variable>]..   # update some variables by the cmd-line
```

### Options

```bash
-d, --disk                             # store on disk in temporary folder
-p, --path <base-dir>                  # store on disk in given folder
-c, --clean                            # remove after restore is done
```

### Files

- `/dev/shm/<prog>[-<ident>].env`     # stored environment
- `/tmp/<prog>[-<ident>].env`         # if `--disk` was used

### Examples


```bash
variables restore
...<code>
variables store # save changes
....
variables store # save changes
....
variables clean # everything done remove progress
```


### Description


The `<ident>` specifies also who will use the same file.
To get the same file in all your invocations of this script only use a fixed string here.
To have a different file for each script invocation include `$$` or '${$}'.
Or to have another file in each sub process include `$BASHPID`.

You may do the following:

- `store` all or some variables
- `restore` all or some variables
- `clean` remove the store
- `change` run a command which will change the variables in the store

