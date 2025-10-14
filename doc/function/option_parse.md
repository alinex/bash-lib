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

### Example

```bash
OPTIONS="
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page"
option_parse "`$OPTIONS`" "$@"
```
