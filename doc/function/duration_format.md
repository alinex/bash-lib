# duration_format

## Format duration in different numbers or human readable

This function can convert into seconds and back into human format as you like. Months or years are not possible because they are not accurately better use 30d or 365 d for that.


### Usage

```bash
duration_format <format> <value>
<format>:   seconds
            minutes     # using floor 110s = 1
            hours       # using floor
            days        # using floor
            human       # like 1h30m, 5w, 30s
```

### Output (stdout)

- `<duration>` in selected format
