# array

## Array analyzation.

### Usage

```bash
array <array-name> <command> [<value>]
```

### Globals

- `<array-name>` as basis to work on

### Output (stdout)

- `<value>` for `has`
- `<index-num>` for `indexof`

### Return (exit code)

- 0 if ok, 1 if entry not found
- 

### Description


This can be used for easy array access functions. The array itself is not given by value but by name, so no `$` before the name.

The following commands ar`<string-input>`e possible:

- `has` to check if a value could be found within the array
- `indexof` will return the index number of the value if found

