# lock

## Set a lock or wait till it can be set

### Usage

```bash
lock
```

### Files

- /tmp/`<prog>`_lockfile        # hard link to active process
- /tmp/`<prog>`_lockfile.`<pid>`  # active or waiting process

### Output (stdout)

`<wait message>`


### Description


In any part of your script you can surround a block with [`lock`](lock.md) and [`unlock`](unlock.md) statements. The
process will wait on the lock statement till no other process with the same lock is running
before going on.

