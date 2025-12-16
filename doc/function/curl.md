# curl

## Curl with added error handling

This will load the content into a temporary shared memory file while running.

The information of the CURL_* variables are stored in an environment file, if `--store` is added, and you get them set in your process parent using `variables restore curl` there.

### Usage

```bash
like curl
```

### Options

```bash
default Options like in vanilla curl
store   # if set `variable store` will be called
```

### Globals

- `CURL_HTTP_CODE` set with last code

### Error (stderr)

`<text>` if not RC:2xx

### Return (exit code)

- 0 if RC:2xx
- 1 if not
- 
