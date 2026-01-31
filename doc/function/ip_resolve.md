# ip_resolve

## Get IP of given hostname

### Usage

```bash
ip_resolve [<option>] host.de
```

### Options

```bash
-v, --version=<int>    # ip version 4 or 6
```

### Output (stdout)

one ip address


### Description


This uses `getent` which may take some seconds to resolve. But if `dig` is installed this will be used, because it works faster.

