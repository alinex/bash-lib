# curl

## Curl with added error handling



### Usage

```bash
like curl
```

### Globals

- `$server`
- `$login` - default is "operator"
- CURL_HTTP_CODE set with last code

### Error (stderr)

- `<text>` if not RC:2xx

### Return (exit code)

- 0 if RC:2xx
- 1 if not
