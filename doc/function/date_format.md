# date_format

## Format date in different named versions or format string

### Usage

```bash
date_format <format> [<value>] # use now if missing
<format>:   iso         2025-10-01T12:00:00+02:00
            iso-date    2025-10-01
            zulu        2025-10-01T10:00:00Z
            sql         2025-10-01 12:00:00
            unix        1759312800
            eu-date     01.10.2025
            us-date     10/01/2025
            human-date  Mittwoch, Oktober 01, 2025
            time        12:00:00
            time-short  12:00
            %Y          2025 (custom format)
```

### Output (stdout)

`<string>` in selected format


### Description


The `<value>` can be unix timestamp (seconds since 1970) or a parsable date format.

