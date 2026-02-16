# queue

## Run bash commands parallel with limits from a queue.

### Usage

```bash
queue [<options>] add <job> [<args>...]             # add job to queue
queue [--progress] run [<parallel>] [<load-percent>] # run the queue with specified limits
```

### Options

```bash
-v, --verbose           # display notice/info message
-n, --name=<string>     # define name or use command with args
-p, --progress          # show progress
- info message for finish (in verbose mode)
- info with progress of queue
```

### Description


The queue first collects all jobs and then you execute them all in parallel. Therefore you can give a max number of parallel calls and a max percentage load limit for then to start the next job.
You may also set the limits using environment `$QUEUE_MAX_PARALLEL` and `$QUEUE_MAX_LOAD`.
If the server is over the configured load limit one job will always run, but parallel execution will only start if possible.

Stderr:   - notice message for start (in verbose mode)

