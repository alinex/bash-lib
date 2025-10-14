# num_parameters

## Check that a specific number of parameters are given



### Usage

```bash
num_parameters "$@" --min 1 --die "Zu viele Parameter: `$USAGE`"
```

### Options

```bash
--min <int>     # at least <int> elements are needed
--max <int>     # not more than <int> elements are allowed
--die <string>  # exit with this message if not
```
