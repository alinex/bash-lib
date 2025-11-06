# remote_bashlib

## Run bashlib command on remote.

The `modules` are a comma separated list of module names like network os.
The modules can be:
- `base` or `full` as first element
- `module/`<name>`` to load the named module (if not full is used)
- `extra/`<name>`` to load an extra module
- `configs` to also transfer all the configurations
- `config/`<name>`` to load only one config
- any other name will be interpreted as `module/`<name>`` (short form)


### Usage

```bash
remote_bashlib <module>[,<module>...] <command> [<args>...]
<command> [<args>...] | remote_bashlib <module>[,<module>...]
remote_bashlib full[,extra/<module>...] <command> [<args>...]
```

### Globals

- `$server`
- `$login` - default is "operator"

### Examples

- IP="$(remote_bashlib ip ip_intern)"
