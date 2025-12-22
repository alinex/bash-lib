# basename

## Strip directory from filepath

### Usage

```bash
basename <path>
<path> | basename
```

### Output (stdout)

`<file>`


### Description

This is a much faster implementation as the basename command because it is using shell parameter expansion.
It will remove the directory and output only the filename.
