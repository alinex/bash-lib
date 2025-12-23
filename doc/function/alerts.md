# alerts

## Get Grafana alerts

### Usage

```bash
alerts [<format>]                       # tsv, json, console, mattermost
alerts -i "^`$server`" console || echo "" # will print the alerts with an empty line if there are some
```

### Options

```bash
a, alertname <regexp>               # select alert name
n, net <name>                        # select network name
i, instance <regexp>                 # select only matching instances
s, summary <regexp>                  # select by summary text
q, quiet                             # return only status code
```

### Output (stdout)

- `format=json` - directly like in the Grafana API
- `format=mattermost` - json in the format of mattermost attachments
- `format=tsv` - Tab separated table
- `format=console` - like tsv but colorized and fixed column width instead of tabs

### Return (exit code)

- 0 - no alerts
- `<num>` - at least one alert
- 0 - without output if no `$GRAFANA_API` + `$GRAFANA_TOKEN`
- 

### Description


The list can be filtered by options and a specific output format can be selected.

