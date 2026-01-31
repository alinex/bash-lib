# sync

## Run the given command with optional step control

### Usage

```bash
sync [<options>] <command> [<params>...]
```

### Options

```bash
-v, --verbose           # display notice/info message
-n, --name=<string>     # define name or use command with args
- info message for finish (in verbose mode)
```

### Description


The command and arguments given will be called like directly run. But if [`steps`](steps.md) is started it will check if already done.
Further in `--verbose` mode a message for start and end will be printed on STDERR with the command or the given `--name`.

Stderr:   - notice message for start (in verbose mode)

