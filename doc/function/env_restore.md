# env_restore

## Restore environment from shared memory/file

If some variable names are given only those will be restored.


### Usage

```bash
env_restore [<ident>] [<variable>]...
```

### Options

```bash
-d, --disk                          # store on disk in temporary folder
-p, --path <base-dir>               # store on disk in given folder
```

### Files

- `/dev/shm/`<program>`_`<ident>`_`<sub-pid>`.env.sub` very short temporary file to filter input
