# powerdns

## Query PowerDNS to get a list of managed domain names



### Usage

```bash
powerdns <pattern>
```

### Globals

- `POWERDNS_API` + `POWERDNS_TOKEN` if powerdns is possible

### Output (stdout)

- ``<tsv>`` with header line

### Return (exit code)

- 0 - without output if no `POWERDNS_API` + `POWERDNS_TOKEN`
