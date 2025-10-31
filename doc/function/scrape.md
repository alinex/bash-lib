# scrape

## Scrape prometheus exporter url now

The metrics can be filtered by `<pattern>` argument.
Stdout:   Tab separated list:


### Usage

```bash
scrape <url> <pattern>
<metric>    [<value>=<text>],...    <value>
...
```

### Return (exit code)

- 0 if metrics found
- 1 if no matching metric
