# remote_console

## Deprecated: Open an interactive console on remote host

Use: remote console
The motd and banner are prevented by touching .hushlogin on the server.

### Usage

```bash
remoteconsole [<options>]
```

### Options

```bash
l, login <user>
h, host <host>
j, jump <user>@<host>
A, forward-agent     # use local ssh-agent also on remote host for authentication.
```

### Globals

- `$server`
- `$login` - default is "operator"

### Output (stdout)

passed through

### Return (exit code)

- passed through
- 
