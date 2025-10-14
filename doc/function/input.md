# input

## Collect string from stdin (no parameters) or concatenate the parameters

This can be used to make functions which you can feed with one or multiple parameters as well as through a pipe.
See also: [`input_args`](function/input_args.md) [`input_lines`](function/input_lines.md)


### Usage

```bash
input "$@" | ....
text="$(input "$@")"
```

### Output (stdout)

- `<string-input>` or
- `<string-params>` separated by spaces
