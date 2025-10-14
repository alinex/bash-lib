# remote_df

## Remote df with visual display

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
