# plusserver_dns

## Query Plusserver DNS to get a list of managed domain names

Returns:  0 - without output if no `$PLUSSERVER_PORTAL`


### Usage

```bash
powerdns
```

### Globals

- `$PLUSSERVER_PORTAL`              if plusserver as provider is used

### Output (stdout)

- Tab separated table:
- NAME        TYPE    CONTENT         TTL
- `<dns-name>`  A                       `<seconds>`
- `<dns-name>`  CNAME   `<destination>`   `<seconds>`
- and more...
