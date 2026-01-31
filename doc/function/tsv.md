# tsv

## Transform tab separated table

### Usage

```bash
<string> | tsv crop <num|name> <width>                 # crop column
<string> | tsv sort <num|name> [numeric] [<options>]   # sort by column
<string> | tsv reverse [<options>]                     # reverse order
<string> | tsv to {csv|pprint} [<options>]             # convert
<string> | tsv filter [<num|name> <pattern>]           # filter some rows
```

### Options

```bash
--with-header              # keep first line as header in `sort`, `reverse`
--remove-header            # remove first (header) line
--color-red <pattern>      # to colorize in `pprint`
--color-yellow <pattern>   # to colorize in `pprint`
--color-blue <pattern>     # to colorize in `pprint`
```

### Examples

- `<string> | tsv filter --remove-header`


### Description


The main element for tabular data within the BashLib is tab separated values which can easily used in bash.
This command collection help with some common use cases to make them easier to write.

To run multiple actions call it multiple times in a pipe.

