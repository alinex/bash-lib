# steps

## Step control allows jobs to resume on another run.

### Usage

```bash
steps init [<name>]     # to start step control
steps end               # to end step control
```

### Description


After starting step control this will be used in [`sync`](sync.md), [`async`](async.md) and [`queue`](queue.md).
To specify which variables to store set `$STEPS_VARIABLES` but before the `init` command.


