# mktemp

## Make a temporary file, which can be recognizable/individual

As the same invocation from the same program will get the same file it can be called multiple times, as long as no `--random` is set.
The file will be conducted out of the program name and the given ``<identifier>``.

You should remove this file by yourself if it is no longer needed. The files will be available in `/tmp` folder for about 3 unused days (managed by your os) and in memory till the next reboot.


### Usage

```bash
mktemp [<identifier>]       # use default temp if no identifier given
```

### Options

```bash
-d, --directory             # to make a directory instead of a file
-m, --memory                # use shared memory
-e, --extension=<string>    # to specify file extension (better readability)
-p, --path=<base-dir>       # folder under which to create file
-r, --random                # add a random (numeric) part to the identifier
-T, --ttl=<duration>        # duration to remove file again as seconds or duration [`duration_format`](duration_format.md)
```

### Output (stdout)

- `<path>`
- Debug: path and if it is created
- Debug: remove after TTL
