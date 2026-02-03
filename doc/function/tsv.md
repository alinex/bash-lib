# tsv

## Transform tab separated table

### Usage

```bash
<string> | tsv crop <num|name> <width>                  # crop column
<string> | tsv sort <num|name> [numeric/human] [<options>]    # sort by column
<string> | tsv reverse [<options>]                      # reverse order
<string> | tsv to {csv|pprint} [<options>]              # convert
<string> | tsv filter [<type> <num|name> <operator> <comparison>]   # filter some rows
```

### Options

```bash
--with-header              # keep first line as header in `sort`, `reverse`
--remove-header            # remove first (header) line
--unique                   # removes duplicate lines (only in tsv sort)
```

### Examples

- `<string> | tsv filter --remove-header`


### Description


The main element for tabular data within the BashLib is tab separated values which can easily used in bash.
This command collection help with some common use cases to make them easier to write.

To run multiple actions call it multiple times in a pipe.

The **filter** command uses [`check`](check.md) to do it's work so `<type>` `<operator>` `<comparison>` are all passed through.
To combine multiple filters pipe it through the command multiple times to have AND condition.
Run the original string a second time through `tsv filter --remove-header...` to habe an OR condition (this may lead to duplicate lines, which you may remove with a sort).

