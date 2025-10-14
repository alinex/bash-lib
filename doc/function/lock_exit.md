# lock_exit

## Set the lock or exit with optional error message

Files:    /tmp/`<prog>`-lockfile        # hard link to active process
In any part of your script you can surround a block with lock and unlock statements. The
process will wait on the lock statement till no other process with the same lock is running
before going on.


### Usage

```bash
lock_exit
/tmp/<prog>-lockfile.<pid>  # active or waiting process
```
