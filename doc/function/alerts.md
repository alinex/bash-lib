# alerts

## Get grafana alerts

Stdout:   `<header-line>`


### Usage

```bash
alerts [<format>]           # json, console, mattermost
```

### Options

```bash
-i, --instance <regexp>     # select only matching instances
-q, --quiet                 # return only status code
<severity>	<network>	<instance>	<decription>	<time>
...
```

### Return (exit code)

- `0` = no alerts, `1` at least one alert
