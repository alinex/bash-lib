# env_store

## Store environment into shared memory/file

Use `$$` or '${$}' as the program PID which will be also the same in Subshells or `${BASHPID}` which will differ.


### Usage

```bash
env_store [<ident>]                 # store complete environment
env_store [<ident>] [<variable>]... # store only listed variables (ident can be empty string)
```

### Options

```bash
-d, --disk                          # store on disk in temporary folder
-p, --path <base-dir>               # store on disk in given folder
```

### Examples

- env_restore
- ...`<code>`
- env_store # save changes
- ....
- env_store # save changes
- ....
- env_clean # everything done remove progress
