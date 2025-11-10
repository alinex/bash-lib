# random

## Return a random string in specific length

The default length is 16.
The ``<pattern>`` is a list of allowed characters in range:
- num - `0-9`
- letters - 'a-z'
- LETTERS - 'A-Z'
- alpha - `a-zA-Z`
- alphanum - `a-zA-Z0-9`
- base64 - `a-zA-Z0-9+/`
- printable - `a-zA-Z0-9!@#$%^&*()-_=+[](){}|;:,.`<>`?/` (in german including umlaut)
- hex - `0-9a-f`
- HEX - `0-9A-F`
- directly give pattern


### Usage

```bash
random <pattern> [<length>]
```
