# disk

## File system analyzation

### Usage

```bash
disk [options] <format> [<path>]...
```

### Options

```bash
-l, --local                                 # show only local file systems
-f, --free [<operator>]<percent%|bytes>     # filter only matching file systems
```

### Description


The following formats are defined:

- `list`    only list mounts
- `data`    all data as tsv table
- `console` colored visual output


