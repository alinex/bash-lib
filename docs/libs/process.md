title: Process

# Process Serial/Parallel

This methods will help you to lock a special process that it can't run in parallel using file based locks.
If the same lock is used another time in another process or sub process it will wait till the first one releases the flag. You have to give a lock file path to be used as flag.

Another part allows to simplify parallel tasks which may be subroutines or commands.

## Include

First you have to include this helper in your bash script:

```bash
source ../bash-lib/process.bash # load functions
```

After that you can use one of the following methods.

## Locking

In any part of your script you can surround a block with `lock` and `unlock` statements.
The process will wait on the `lock` statement till no other process with the same lock is running before going on.

!!! abstract "Function: lock"

    Used to set the lock or wait and set it, if already locked.

    **Parameter:**

    - full path to use as lock file which should be writable (default to `LOCKFILE`)

!!! abstract "Function: unlock"

    Used to remove the lock.

    **Parameter:**

    - full path to use as lock file which should be writable (default to `LOCKFILE`)

A simple locking will look like:

```bash
lockfile=/tmp/my-program-lock
lock $lockfile   # create the lock
# here comes the critical code
# which will run only once at a time
unlock $lockfile # remove the lock
```

As an alternative `lock_exit` can be used to abort if this is already locked. It won't wait till it can get the lock but exit immediately.

!!! abstract "Function: lock_exit"

    Try to set the lock, if not possible exit the whole process there with an error message.

    **Parameter:**

    - full path to use as lock file which should be writable (default to `LOCKFILE`)
    - error-message (default: `Stop processing because this is locked in $lockfile`)
    - error-code (default is `1`)

```bash
lock_exit $lockfile $message $code  # ... and exit if already locked
```

If you don't give a lockfile the environment variable `LOCKFILE` or `tmp/<process-name>-lock` will be used.

### Configuration

The only configurable value here beside the logging is:

```bash
LOCKFILE="tmp/$(basename $0)-lock" # use name of current process
LOCK_SLEEP=10 # time to wait till retrying if other process locked it
```

### Checking the Lock

The locking is done by local files whose name part is given or used from the current running
script. so `mx-program` will work like:

1. The `lock` is set by making a file containing the filename with the PID as file extension and content. This indicates, that this PID is waiting to retrieve the lock like `/tmp/my-program-lock.1587`
2. remove lockfile `/tmp/my-program-lock` if the process within is no longer active
3. Create a softlink without extension for it `/tmp/my-program-lock -> /tmp/my-program-lock.1587` if there is already such an softlink, try again every second.
4. Remove the softlink and the lock with the PID on `unlock`

If the program is terminated in between some old files may be present. The code also contains a `trap` to prevent such problems by removing them also on breaks.

While waiting to get the lock the process is:

1. wait the defined time `$LOCK_SLEEP`
2. if the PID file `/tmp/my-program-lock.1587` got lost recreate it
3. remove lockfile if the process within is no longer active
4. retry creating the softlink

You can always remove all the lock files by hand if the PID is no longer running. But this should neither be needed.

## Asynchronous Calls

Running some tasks in parallel can save time but may be problematic to manage. This functions help to simplify this tasks.

!!! abstract "Function: async"

    Run the given command asynchronous ang go on in the calling routine.

    **Parameter:**

    - command to execute, which may be a subroutine or real shell command
    - optional arguments for the command

!!! abstract "Function: async_name"

    Alternative to `async` in which this call is given a name to refer in `async_wait`.

    **Parameter:**

    - any unique identifier
    - command to execute, which may be a subroutine or real shell command
    - optional arguments for the command

!!! abstract "Function: async_wait"

    Check if the command is done or wait here till it is so.

    **Parameter:**

    - identifier from `async_name` or the command from `async` call
    - function to call if a failure occurred within the process

A simple call will be:

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

Additionally you can give a function name as second parameter to `async_wait` which will be called with an error message if the asynchronous function returned an error code. See at step control below for an example.

To wait for all asynchronous processes to end use only `wait`, but then you won't get the individual return codes.

### Configuration

The possible configuration beside logging is:

```bash
LOCK_SLEEP=10 # time to wait before rechecking for the lock
LOCKFILE="/tmp/$(basename $0)-lock" # lockfile used if none given in function call
STEPFILE="/tmp/$(basename $0)-steps" # for async steps (see below)
```

### Step Control

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

failed() {
  log_exit ALERT "$1"
}

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

{!docs/assets/abbreviations.txt!}
