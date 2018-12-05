# Process Serialize/Parallelize

This methods will help you to lock a special process that it can't run in parallel using file based locks.
If the same lock is used another time in another process or sub process it will wait till the first one releases the flag. You have to give a lock file path to be used as flag.

Another part allows to simplify parallel tasks which may be subroutines or commands.

## Usage

First you have to include this helper in your bash script:

```bash
source ../bash-lib/process.bash # load functions
```

### Locking

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
lock_exit $lockfile $message $code  # ... and exit if already locked
```

If you don't give an lockfile the environment variable `LOCKFILE` or `tmp/processname-lock` will be used.

### Async

Running some tasks in parallel can save time but may be problematic to manage. This methods
help to simplify this tasks.

```bash
f1() {
  sleep 5
  echo "done f1 with value $1 (=155)"
}

async f1 155
echo "comes first"
async_wait f1
echo "done"
```

The function `f1` is called asynchronously and while this runs the following echo statement will be called. `async_wait`

If the same command or function is used multiple times in parallel use `async_name` which
let`s you also define an individual identifier:

```bash
async_name f1_1 f1 155
async_wait f1_1
```

To wait for all async processes to end use `wait`, but then you won't get the individual return codes.

## Configuration

The only possible configuration is:

```bash
LOCK_SLEEP=10 # time to wait before rechecking for the lock
LOCKFILE="/tmp/$(basename $0)-lock" # lockfile used if none given in function call
STEPFILE="/tmp/$(basename $0)-steps" # for async steps (see below)
```

## How locking works

The locking is done by local files whose name part is given or used from the current running
script. so `mx-program` will work like:

1. The `lock` is set by making a file containing the filename with the PID as file extension and content. This indicates, that this PID is waiting to retrieve the lock like `/tmp/my-program-lock.1587`
2. Create a softlink without extension for it `/tmp/my-program-lock -> /tmp/my-program-lock.1587` if there is already such an softlink, try again every second.
3. Remove the softlink and the lock with the PID on `unlock`

If the program is terminated in between some old files may be present. The code also contains a `trap` to prevent such problems by removing them also on breaks. But if something abnormally happens, you should remove all the lock files by hand if the PID is no longer running.

## Async Step Control

If a `STEPFILE` is defined each step will be checked if is already done (entry in the file).
Only if not done it will be started. So a process which is canceled within can be processed further on.

The stepfile will look like:

    Finished: step f1 at 2018-11-15 09:54
    Finished: step f2 at 2018-11-15 09:56

But if the process is finished, the file will be removed.

A complete integration may look like:

```bash
# Configuration
STEPFILE=${STEPFILE:-/tmp/$(basename $0)-steps}
WORK_DATE=${WORK_DATE:-$(date +%Y-%m-%d)}

lock_exit # exit if same process is already running

# Remove old stepfile (not from the current running date)
[ -e $STEPFILE ] \
&& [ "$(date -d "$(stat -c %y $STEPFILE)" +%Y-%m-%d)" != "$WORK_DATE" ] \
&& rm $STEPFILE

# Log message if continue of old run
if [ -e $STEPFILE ]; then
  log WARN "A previously aborted process for $WORK_DATE is found, trying to continue after:"
  cat $STEPFILE | log INFO
fi

# If process is stopped, also stop subprocesses
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Write start to stepfile
echo "Starting process at $(date '+%Y-%m-%d %H:%M:%S')" >>$STEPFILE

# Call the steps
async f1
async f2
async_wait f1 failed
async_wait f2 failed

# Cleanup
rm $STEPFILE # clear steps
trap - SIGINT SIGTERM EXIT # remove trap
unlock # free the file lock
```
