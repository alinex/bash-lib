# curl

## Curl with added error handling

This will load the content into a temporary shared memory file while running.

The information of the CURL_* variables are stored in an environment file because of the different processes you have to make the changes visible using `env_restore curl`. After that you may use them.

### Usage

```bash
like curl
```

### Globals

- `CURL_HTTP_CODE` set with last code

### Error (stderr)

`<text>` if not RC:2xx

### Return (exit code)

- 0 if RC:2xx
- 1 if not
- 
