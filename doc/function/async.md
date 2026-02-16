# async

## Run the given command asynchronous ang go on in the calling routine

### Usage

```bash
async [<options>] <command> [<params>...]
async [<options>] wait [<command> [<params>...]]
```

### Options

```bash
-v, --verbose           # display notice/info message
-n, --name=<string>     # define name or use command with args
- info message for finish (in verbose mode)
```

### Examples


```bash
async task1
async task2
async wait task1
async task3
wait # for all to end
```


### Description


While this command runs you may start more [`async`](async.md) commands and use [`async_wait`](async_wait.md) to wait for a specific one to end or all to end.

The command and arguments given will be called like directly run. But if [`steps`](steps.md) is started it will check if already done.
Further in `--verbose` mode a message for start and end will be printed on STDERR with the command or the given `--name`.

Stderr:   - notice message for start (in verbose mode)
