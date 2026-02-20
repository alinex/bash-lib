# duration_format

## Format duration in different numbers or human readable

### Usage

```bash
duration_format <format> <seconds>|<human>
```

### Output (stdout)

`<duration>` in selected format


### Description


This function can convert into seconds and back into human format as you like.

The following `<format>` specifiers are possible:

- `seconds`
- `minutes`     - using floor 110s = 1 (minute)
- `hours`       - using floor
- `days`        - using floor
- `weeks`       - using floor
- `months`      - using floor and using 365.25 / 12 days
- `years`       - using floor and using 365.12 days
- `human`       - like 5w, 1h 30m, 30s # spaces between different units are optional

Within the human string you may use the following number parts:

- seconds: `<num>`, s, sec, secs, second, seconds
- minute: m, min, mins, minute, minutes
- hour: h, hr, hrs, hour, hours
- day: d, day, days
- week: w, week, weeks
- month: mo, mon, month, months
- year: y, yr, year, years

