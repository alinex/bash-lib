# powerdns

## Query PowerDNS to get a list of managed domain names

### Usage

```bash
powerdns <pattern>
```

### Globals

- `$POWERDNS_API` + `$POWERDNS_TOKEN` if powerdns is possible

### Output (stdout)

Tab separated `<table>`:

```
NAME        TYPE    CONTENT         TTL
<dns-name>  A                       <seconds>
<dns-name>  CNAME   <destination>   <seconds>
and more...
```

### Return (exit code)

- 0 - without output if no `POWERDNS_API` + `POWERDNS_TOKEN`
- 

### Description


