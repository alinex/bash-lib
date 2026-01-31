# option_parse

## Parse arguments based on given specification

### Usage

```bash
option_parse <spec> <arguments>
<spec> lines := <short-letter>|- <long-word> <type>?|- <description>
```

### Output (stdout)

**parsed and ordered options `<string>`**:

- the options are at the start
- then the double dash `--` also if not given
- and at last all other arguments

### Examples

- `eval set -- "$(option_parse <spec> "$@")"` the common use case
- [`base_script`](../example/base_script.md) includes a simple example


### Description


This will parse the given options into a standardized form and validate them against the given specification.

The key for this is the specification string, which consists of a list of lines for each option. Each line contains up to four parts separated by space:

- `<short-letter>` only one letter allowed, but you can set it to `-` if no short option needed
- `<long-word>` the long option which have to be there, use dashed words if multiple
- `<type>` append '?' at the end if the value is optional or set to `-` if no value needed, else the type of value to be printed in help or `+` in internal function for undefined type
- `<description>` only for the help message

For internal functions we don't need the [`option_help`](option_help.md) command, so the type of options in the `<spec>` will be shortened to +/- and a `<description>` is not needed.
Permutation, reordering and giving options after arguments, is possible by default but can be removed if the whole `<spec>` begins with `+`. Without permutation you won't need the `--` delimiter because all are arguments after the first non option.

Options can be given in different forms: `-a 45`, `-a45`, `--age 45`, `--age=45` are all equal. The last one is preferred because of readability.

Also multiple short options can be put together with only the last may need a value.

**Unknown options** will be pushed through without an error, you have to check for them later by yourself to give better error messages then we could here. The corelation between name and value can be broken here. So neither use this intentionally, you always have to check it and break with an unknown option error.

