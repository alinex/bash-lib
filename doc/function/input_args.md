# input_args

## Collect string from stdin (not more than defined parameters) or concatenate the parameters

This can be used to make functions which you can feed with one or multiple parameters as well as through a pipe.
But instead of the [`input`](input.md) this will allow the first `<num>` additional parameters which will be not slurped in.


### Usage

```bash
input_args <num> "$@" | ....
text="$(input <num> "$@")"
```

### Output (stdout)

- ``<string-input>`` or
- ``<string-params>`` separated by spaces
