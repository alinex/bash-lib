# remote_term

## Deprecated: Run remote command with pseudo terminal

Use: remote --terminal ...
``
` my be contained in output, remove with n@ocr`
"Connection ... closed" in stderr: remove using: 2>` >`(grep -v '^Connection to .* closed\.' >`[`2`](../example/2.md))

### Usage

```bash
remote_term [<options>] <command>... # special characters have to be masked: | & * > <
<title> | remote_term [<options>]
```

### Options

```bash
# following options, only before `<command>`
l, login <user>
h, host <host>
j, jump <user>@<host>
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

passed through

