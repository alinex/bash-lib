# lock

## Set a lock or wait till it can be set

Stderr:   `<wait message>`
In any part of your script you can surround a block with lock and unlock statements. The
process will wait on the lock statement till no other process with the same lock is running
before going on.


### Usage

```bash
lock
```

### Files

- /tmp/`<prog>`-lockfile        # hard link to active process
- /tmp/`<prog>`-lockfile.`<pid>`  # active or waiting process
