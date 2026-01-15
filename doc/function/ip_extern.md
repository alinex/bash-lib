# ip_extern

## Run  os detection and set the constants

### Usage

```bash
ip_extern <format>
```

### Options

```bash
v, version=<int>    # ip version 4 or 6
```

### Output (stdout)

`<tsv-table>` for data
`<value>` else


### Description


The following formats are possible:

- data - all values with `<name>	<value>`
- country
- countryCode
- region
- regionName
- city
- zip
- lat
- lon
- timezone
- isp
- org
- as
- ipv4
- ipv6

