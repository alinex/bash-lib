# remote_term

## Run remote command with pseudo terminal


 my be contained, remove with nocr
"Connection ... closed" in stderr: remove using: 2>` >`(grep -v '^Connection to .* closed\.' >`[`2`](../example/2.md))


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
