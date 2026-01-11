# exporter

## Get exporter list

### Usage

```bash
exporter [<field>=<value>]...
```

### Globals

- `$PROMETHEUS_HOST` + `$PROMETHEUS_API`

### Output (stdout)

Tab separated list without header:
`<url>   <job>   <label-values>`

### Return (exit code)

- 0 without output if no `$PROMETHEUS_HOST` + `$PROMETHEUS_API`
- 

### Description


The result can be filtered by additional argument specification.

