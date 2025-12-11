# dns_list

## Query all managed DNS servers to get a complete list of domain names

It will output only the header line if no DNS system is available. Possible DNS systems are:

- [`powerdns`](powerdns.md) - PowerDNS https://www.powerdns.com/
- [`plusserver_dns`](plusserver_dns.md) - the DNS in the Plusserver Cloud https://www.plusserver.com/

### Usage

```bash
dns_list <pattern>
```

### Globals

- `$POWERDNS_API` + `$POWERDNS_TOKEN` if powerdns is possible
- `$PLUSSERVER_PORTAL`              if plusserver as provider is used

### Output (stdout)

Tab separated `<table>`:

```
NAME        TYPE    CONTENT         TTL
<dns-name>  A                       <seconds>
<dns-name>  CNAME   <destination>   <seconds>
and more...
```

