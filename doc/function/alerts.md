# alerts

## Get grafana alerts

Stdout:   `<header-line>`


### Usage

```bash
alerts [<format>]                       # json, console, mattermost
alerts -i "^`$server`" console || echo "" # will print the alerts with an empty line if there are some
```

### Options

```bash
-i, --instance <regexp>                 # select only matching instances
-a, --alertname <regexp>                # select alert name
-q, --quiet                             # return only status code
<severity>	<network>	<instance>	<decription>	<time>
...
```

### Return (exit code)

- 0 := no alerts
- 0 := at least one alert
