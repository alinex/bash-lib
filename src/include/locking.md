# Locking Process

This methods will help you to lock a special process that it can't run in parallel.
If the same lock is used another time in another process or sub process it will wait till the first one releases the flag. You have to give a lock file path to be used as flag.

## Usage

First you have to include this helper in your bash script:

```bash
source ../bash-lib/locking.bash # load functions
```

Now, in any part of your script you can surround a block with `lock` and `unlock` statements:

```bash
lockfile=/tmp/my-program-lock
lock $lockfile   # create the lock
# here comes the critical code
# which will run only once at a time
unlock $lockfile # remove the lock
```

An alternative is to use the `exit_lock` method which won't wait till it can get the lock but exit immediately:

```bash
exit_lock $lockfile $message $code  # ... and exit if already locked
```

## Configuration

The only possible configuration is:

```bash
LOCK_SLEEP=10 # time to wait before rechecking for the lock
```

## How it works

1. The `lock` is set by making a file containing the filename with the PID as file extension and content. This indicates, that this PID is waiting to retrieve the lock like `/tmp/my-program-lock.1587`
2. Create a softlink without extension for it `/tmp/my-program-lock -> /tmp/my-program-lock.1587` if there is already such an softlink, try again every second.
3. Remove the softlink and the lock with the PID on `unlock`

If the program is terminated in between some old files may be present. The code also contains a `trap` to prevent such problems by removing them also on breaks. But if something abnormally happens, you should remove all the lock files by hand if the PID is no longer running.
