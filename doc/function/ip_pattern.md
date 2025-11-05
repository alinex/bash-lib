# ip_pattern

## Find info about IP by configured patterns.

Possible types are like in the configuration:
- provider
- segment
- vmware
If no pattern matches there won't be any rteturn value


### Usage

```bash
ip_pattern <type> [<ip>]
```

### Output (stdout)

- `<value>` of first matching line

### Return (exit code)

- 1 if no match found
