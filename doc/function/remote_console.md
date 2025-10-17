# remote_console

## Open an interactive console on remote host

The motd and banner are prevented by touching .hushlogin on the server.


### Usage

```bash
remote_console
```

### Options

```bash
-A, --forward-agent     # use local ssh-agent also on remote host for authentication.
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

- passed through

### Return (exit code)

- passed through
