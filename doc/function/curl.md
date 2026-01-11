# curl

## Curl with added error handling

### Usage

```bash
like curl
```

### Options

```bash
default Options like in vanilla curl
store <name>  # if set `variables store <name>` will be called
```

### Globals

- `CURL_HTTP_CODE` set with last code

### Error (stderr)

`<text>` if not RC:2xx

### Return (exit code)

- 0 if RC:2xx
- 1 if not
- 

### Description

This will load the content into a temporary shared memory file while running.

The information of the CURL_* variables are stored in an environment file, if `--store <name>` is added, and you get them set in your process parent using `variables restore <name>` there. Best is to use the pid `$$` there, to be possible in parallel calls.

