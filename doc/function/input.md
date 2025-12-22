# input

## Collect string from stdin (no parameters) or concatenate the parameters

### Usage

```bash
input "$@" | ....
text="$(input "$@")"
```

### Output (stdout)

`<string-input>` or
`<string-params>` separated by spaces


### Description


This can be used to make functions which you can feed with one or multiple parameters as well as through a pipe.
See also: [`input_args`](input_args.md) [`input_lines`](input_lines.md)

