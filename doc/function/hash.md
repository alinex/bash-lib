# hash

## Methods to work with assoziative arrays (hashes)

### Usage

```bash
hash <array-name> set <key> [<value>]
hash <array-name> get <key> [<value>]
hash <array-name> unset <key>
hash <array-name> has <key>
hash <array-name> contains <key>
hash <array-name> to tsv
```

### Options

```bash
-k, --key-format={base64|simple}    # how to convert key because of special characters
```

### Globals

- `<array-name>` as basis to work on

### Output (stdout)

`get`: `<value>` if found

### Error (stderr)

`get` / `has`: 1 if not found

### Examples

- `hash cache set "my_name" "any value"`
- `hash cache get "my_name"`
- `hash cache has "my_name"`
- `hash cache unset "my_name"`


### Description


After declaring a variable as associative array: `declare -A <array-name>` this commands may help working with it. The array itself is not given by value but by name, so no `$` before the name.

As an assoziative array allows not all characters for the key, the key can be:

- `simple` (default) - unsupported characters will be replaced by _: "my %key" =>` "my__key"
- `base64` - encode the whole key as base64: "my %key" =>` "bXkgJWtleQo="

The following commands are possible:

- `set` add or update a `<value>` in the index
- `get` get the stored value for `<key>`
- `unset` remove `<key>` from hash
- `has` check if the `<key>` is set
- `contains` check if the given `<value>` is found in any key
- `to` converts hash into `tsv`

