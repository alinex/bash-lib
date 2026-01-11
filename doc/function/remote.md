# remote

## Run command on remote host.

### Usage

```bash
remote [<options>] <command>...     # special characters in command masked with backslash ( | & * > < $ )
<commands> | remote [<options>]     # pipe the command which prevents masking
remote [<options>] --file <file>    # run file content on remote host
remote [<options>] console          # open a remote console to the user
remote [<options>] bashlib <modules> <command>...         # run bashlib command on remote (no need to be installed)
```

### Options

```bash
# following options, only before `<command>`
l, login <user>         # username for login
h, host <host>          # destination host
j, jump <user>@<host>   # to use a jump host before
t, terminal             # to use a pseudo terminal
line-based              # line based return for terminal
f, file                 # the command is a file reference which has to be used
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

passed through

### Return (exit code)

- Error code from remote command
- (255) will die because it is a connection problem
- (143) will exit because it was from a SIGTERM on the remote

### Examples

[`remote`](../example/remote.md) shows how to use it


### Description


You can let it use the ``$server`` and ``$login`` variables or give it in the options.

If you use a pseudo `--terminal`, ``
` may be contained in output, remove with [`nocr`](nocr.md).`
This will also return "Connection ... closed" in stderr after done. Handle it or use the `--line-based` option, which will return output line by line (problematic on some interactive parts) but without the connection closed message an no `\n`.

If you run a `remote bashlib <modules> <command>` command the `modules` are a comma separated list of module names like network os.
The modules can be:

- `base` or `full` as first element
- `module/<name>` to load the named module (if not full is used)
- `extra/<name>` to load an extra module
- `configs` to also transfer all the configurations
- `config/<name>` to load only one config
- any other name will be interpreted as `module/<name>` (short form)

