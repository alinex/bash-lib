# semver_diff

## Calculate difference

### Usage

```bash
semver_diff [-h] <first> <second> # can already be parsed or not
```

### Options

```bash
-h,--human      # to show it user friendly
```

### Error (stderr)

`<int>` which is:

- >` 1000000000 newer major (num / 1000000000 = steps)
- >` 1000000 newer minor (num / 1000000 = steps)
- >` 1000 newer patch (num / 1000 = steps)
- 10 newer pre-release
- 1  newer build
- 0  identical
- -1 older build
- -10 older pre-release
- `< -1000 older patch (num / 1000 = steps)
- `< -1000000 older minor (num / 1000000 = steps)
- `< -1000000000 older major (num / 1000000000 = steps)

