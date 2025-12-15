# remote

## Run command on remote host.

You can let it use the ``$server`` and ``$login`` variables or give it in the options.

If you use a pseudo `--terminal`, ``
` may be contained in output, remove with [`nocr`](nocr.md).`
This will also return "Connection ... closed" in stderr after done. Handle it or use the `--line-based` option, which will return output line by line (problematic on some interactive parts) but without the connection closed message an no `\n`.

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

### Examples

[`remote`](../example/remote.md) shows how to use it

