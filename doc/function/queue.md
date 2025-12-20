# queue

## Run bash commands parallel with limits from a queue.

The queue first collects all jobs and then you execute them all in parallel. Therefore you can give a max number of parallel calls and a max percentage load limit for then to start the next job.
You may also set the limits using environment `$QUEUE_MAX_NUM` and `$QUEUE_MAX_LOAD`.


### Usage

```bash
queue add <job> [<args>...]             # add job to queue
queue run [<parallel>] [<load-percent>] # run the queue with specified limits
```
