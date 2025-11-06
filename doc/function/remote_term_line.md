# remote_term_line

## Run remote command with pseudo terminal but line based output (problematic with questions)



### Usage

```bash
remote_term_line [<options>] <command>... # special characters have to be masked: | & * > <
<title> | remote_term_line [<options>]
```

### Options

```bash
# following options, only before `<command>`
-l, --login <user>
-h, --host <host>
-j, --jump <user>@<host>
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

- passed through
