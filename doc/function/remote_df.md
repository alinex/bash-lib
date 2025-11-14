# remote_df

## Deprectaed: Remote df with visual display

Use `remote_bashlib os disk_free` instead.
The lines will be colorized based on `$MOUNT_COLOR_LIMIT` setting, which contains sets of 5 entries (pattern critical error warn ok). The first matching pattern will decide the color limits.


### Usage

```bash
remote_df [<mount>...]                              # show table
remote_df <var> <operator> <limit%> [<mount>...]    # additionaly collect specific volumes
```

### Options

```bash
-l, --local     # only list local devices
```
