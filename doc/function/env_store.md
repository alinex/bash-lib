# env_store

## Store environment into shared memory/file



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

### Example

```bash
env_restore
...<code>
env_store # save changes
....
env_store # save changes
....
env_clean # everything done remove progress
```
