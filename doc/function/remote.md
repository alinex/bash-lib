# remote

## Run command on remote host

### Usage

```bash
remote [<options>] <command>... # special characters in command masked with backslash
# <special char> := | & * > < $
<commands> | remote [<options>]
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

