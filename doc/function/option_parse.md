# option_parse

## Parse arguments based on given specification

This will parse the given options into a standardized form and validate them against the given specification.
For internal functions there no [`option_help`](option_help.md) is called, the type of options in the ``<spec>`` can be shortened to +/-.
Permutation, reordering and giving options after arguments, is possible by default but can be removed if the whole ``<spec>`` begins with `+`.
#
Options can be given in different forms: `-a 45`, `-a45`, `--age 45`, `--age=45` are all equal. The last one is preferred because of readability.
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
