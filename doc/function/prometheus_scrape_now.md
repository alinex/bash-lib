# prometheus_scrape_now

## Change scrape interval to scrape now and set back

### Usage

```bash
prometheus_scrape_now <job> [<timeout>]
```

### Globals

- `$PROMETHEUS_HOST` to change config temporarily

### Return (exit code)

- 0 - without output if no `$PROMETHEUS_HOST`
- 
