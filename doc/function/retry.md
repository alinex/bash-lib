# retry

## Retry a command multiple times until it succeeds

Using escalating delay between attempts. Delay is 2 * n + random up to 30s, then 30s + random after that.
For large numbers of retries the max delay is effectively the retry count in minutes.


### Usage

```bash
retry <N> <command> [<params>]...
```
