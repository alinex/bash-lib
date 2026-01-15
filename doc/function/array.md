# array

## Array analyzation

### Usage

```bash
array <array-name> has <value>
array <array-name> indexof <value>
array <array-name> join [<separator>]
```

### Globals

- `<array-name>` as basis to work on

### Output (stdout)

- `indexof`: `<index-num>` for found value

### Return (exit code)

- 0 if entry is found in array
- 1 if entry not found
- 

### Description


This can be used for easy array access functions. The array itself is not given by value but by name, so no `$` before the name.

The following commands ar`<string-input>`e possible:

- `has` to check if a value could be found within the array
- `indexof` will return the index number of the value if found

