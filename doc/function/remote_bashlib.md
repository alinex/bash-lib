# remote_bashlib

## Run bashlib command on remote.

The `modules` are a comma separated list of module names like network os and if they are not in `module/` please add the parent folder.


### Usage

```bash
remote_bashlib <modules> <command> [<args>...]
<command> [<args>...] | remote_bashlib <modules>
```

### Globals

- `$server`
- `$login` - default is "operator"
