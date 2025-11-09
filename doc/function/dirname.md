# dirname

## Strip last component from file path

This is a much faster implementation as the dirname command because it is using shell parameter expansion.
It will remove the last element in path.


### Usage

```bash
dirname <path>
<path> | dirname
```

### Output (stdout)

- `<base-path>`
