# extname

## Returns the extension of the path

### Usage

```bash
extname <path>
<path> | extname
```

### Output (stdout)

`<extension>`


### Description

From the last occurrence of the . (period) character to end of string in the last portion of the path. If there is no . in the last portion of the path, or if the first character of the basename of path (see path.basename()) is ., then an empty string is returned.
