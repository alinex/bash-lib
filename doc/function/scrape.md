# scrape

## Scrape Prometheus exporter url now

The metrics can be filtered by `<pattern>` argument.


### Usage

```bash
scrape <url> <pattern>
```

### Output (stdout)

- Tab separated list:
- ``<metric>`    [`<value>`=`<text>`],...    `<value>``

### Return (exit code)

- 0 if metrics found
- 1 if no matching metric
