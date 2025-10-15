# option_parse

## Parse arguments based on given specification

This will parse the given options into a standardized form and validate them against the given specification.
Options can be given in different forms: `-a 45`, `-a45`, `--age 45`, `--age=45` are all equal.
Also multiple short options can be put together with only the last may need a value.


### Usage

```bash
eval set -- "$(option_parse <spec> "$@")"
<spec> lines := <short-letter>|- <long-word> <type>|- <description>
```

### Output (stdout)

- parsed options `<string>`

### Examples

- [`base_script`](../example/base_script.md) includes a simple example
