# upload

## Upload file

### Usage

```bash
upload [<options>] <source> <dest>
```

### Options

```bash
# following options, only before `<source>`
-l, --login <user>
-h, --host <host>
-j, --jump <user>@<host>
-f, --files <list>      # each file in a line, must be relative from <source>
-d, --delete            # remove all files not in current upload
```

### Globals

- `$server`
- `$login` - default is "operator"
- 

### Description


