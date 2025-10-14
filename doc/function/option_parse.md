# option_parse

## Parse arguments based on given specification

Short options can also be given in short notation "-a45" ->` "-a 45" or "--age 45"


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
