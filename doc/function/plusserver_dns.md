# plusserver_dns

## Query Plusserver DNS to get a list of managed domain names

Because there is no API at plusserver this will work on previously downloaded file. It will give a hint there to download it, which should be done regularly to be up to date.


### Usage

```bash
powerdns <pattern>
```

### Globals

- `PLUSSERVER_PORTAL`              if plusserver as provider is used

### Output (stdout)

- ``<tsv>`` with header line

### Return (exit code)

- 0 - without output if no `PLUSSERVER_PORTAL`
