# remote_term_line

## Run remote command with pseudo terminal but line based output (problematic with questions)



### Usage

```bash
remote <command>... # special characters have to be masked: | & * > <
<title> | remote
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

- passed through
