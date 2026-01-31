# input_lines

## Collect string from stdin (no parameters) or parameters each as a line

### Usage

```bash
input_lines "$@" | ....
text="$(input_lines "$@")"
```

### Output (stdout)

- `<string-input>` or
- `<string-params>` separated by newlines


### Description


The same as [`input`](input.md) for piped content but the arguments will not be joined by spaces but read as separate lines.
See also: [`input`](input.md) [`input_args`](input_args.md)

