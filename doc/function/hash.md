# hash

## Methods to work with assoziative arrays (hashes)

### Usage

```bash
hash <array-name> <command> [<key>] [<value>]
```

### Options

```bash
-k, --key-format={base64|simple} # how to convert key because of special characters
```

### Globals

- `<array-name>` as basis to work on

### Output (stdout)

`<value>` for `get`

### Error (stderr)

1 if not found for `get` or `has`

### Examples

- `hash cache set "my_name" "any value"`
- `hash cache get "my_name"`
- `hash cache has "my_name"`
- `hash cache unset "my_name"`


### Description


After declaring a variable as associative array: `declare -A <array-name>` this commands may help working with it. The array itself is not given by value but by name, so no `$` before the name.

As an assoziative array not allows all characters for the key, the key can be:

- simple (default) - unsupported characters will be replaced by _
- base64 - encode the whole key as base64

The following commands ar`<string-input>`e possible:

- `set` add or update a `<value>` in the index
- `get` get the stored value for `<key>`
- `unset` remove `<key>` from hash
- `has` check if the `<key>` is set
- `contains` check if the given `<value>` is found in any key

