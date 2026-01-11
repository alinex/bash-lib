# duration_format

## Format duration in different numbers or human readable

### Usage

```bash
duration_format <format> <seconds>|<human>
<format>:   seconds
            minutes     # using floor 110s = 1
            hours       # using floor
            days        # using floor
            human       # like 1h 30m, 5w, 30s # spaces between different units are optional
```

### Output (stdout)

`<duration>` in selected format


### Description


This function can convert into seconds and back into human format as you like. Months or years are not possible because they are not accurately, better use 30d or 365d for that.

