# upload

## Upload file

### Usage

```bash
upload [<options>] <source> <dest> [<files>]
```

### Options

```bash
# following options, only before `<source>`
-l, --login <user>
-h, --host <host>
-j, --jump <user>@<host>
-d, --delete            # remove all files not in current upload
```

### Globals

- `$server`
- `$login` - default is "operator"
- 

### Description


If a specified list of files/directories should be transferred, add the folder as source and give an additional list of files/directories from this folder to transfer.
This list has to be a word list delimited by spaces, no newlines.

