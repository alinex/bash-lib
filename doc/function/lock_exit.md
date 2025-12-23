# lock_exit

## Set the lock or exit with optional error message

### Usage

```bash
lock_exit
```

### Files

- /tmp/`<prog>`-lockfile        # hard link to active process
- /tmp/`<prog>`-lockfile.`<pid>`  # active or waiting process
- 

### Description


While another program is running with this lock active it will [`die`](die.md).

