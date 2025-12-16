# env_store

## Deprecated: Store environment into shared memory/file

Use: variables store...
Use `$$` or '${$}' as the program PID which will be also the same in Subshell or `${BASHPID}` which will differ.

### Usage

```bash
store [<ident>]                 # store complete environment
store [<ident>] [<variable>]... # store only listed variables (ident can be empty string)
```

### Options

```bash
d, disk                          # store on disk in temporary folder
p, path <base-dir>               # store on disk in given folder
```

### Files

- `/dev/shm/<prog>[-<ident>].env`     # stored environment

### Examples


```bash
env_restore
...<code>
store # save changes
....
store # save changes
....
env_clean # everything done remove progress
```

