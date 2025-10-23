# exporter

## Get exporter list

The result can be filtered by additional argument specification.
Stdout:   Tab separated list without header:


### Usage

```bash
exporter [<field>=<value>]...
```

### Globals

- `$PROMETHEUS_HOST` + `$PROMETHEUS_API`
- `<url>`   `<job>`   `<label-values>`
- ...

### Return (exit code)

- 0 without output if no `$PROMETHEUS_HOST` + `$PROMETHEUS_API`
