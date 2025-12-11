# num_parameters

## Deprecated: Check that a specific number of parameters are given

Use: is integer $# --min=1 --max=2


### Usage

```bash
num_parameters "$@" --min 1 --die "Zu viele Parameter: `$USAGE`"
```

### Options

```bash
min=<int>     # at least <int> elements are needed
max=<int>     # not more than <int> elements are allowed
die=<string>  # exit with this message if not
```
