# disk_free

## Disk free with visual display

The lines will be colorized based on ``$MOUNT_COLOR_LIMIT``` setting, which contains sets of 5 entries (pattern critical error warn ok). The first matching pattern will decide the color limits.`

If a `--free` condition and `--collect` is given all disks violating this will be collected as string within the collection variable for further use.

### Usage

```bash
disk_free [options] [<mount>...]            # show table
```

### Options

```bash
l, local     # only list local devices
c, collect <variable-name>
f, free [<operator>]<percent%|bytes>
```

### Output (stdout)

# same as `df` command but colorized

