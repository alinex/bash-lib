# mktemp

## Make a temporary file, which is recognizable

As the same invocation from the same program will get the same file it can be called multiple times.


### Usage

```bash
mktemp [<identifier>]       # use default temp if no identifier given
```

### Options

```bash
-d, --directory             # to make a directorty instead of a file
-m, --memory                # use shared memory
-e, --extension <string>    # to specify file extension (better readability)
-p, --path <base-dir>       # folder under which to create file
```

### Output (stdout)

- `<path>`
