# Add timestamp to lines

This script will add the current timestamp to each line while it is piped through.

## Usage

    ts [-r] [-i | -s] [format]

## Format

The optional format parameter controls how the timestamp is formatted,
as used by `strftime(3)`. The default format is "%b %d %H:%M:%S". In
addition to the regular strftime conversion specifications,
"%.S" and "%.s" and "%.T"
are like "%S" and "%s" and "%T", but provide subsecond resolution
(ie, "30.00001" and "1301682593.00001" and "1:15:30.00001").

If the `-r` switch is passed, it instead converts existing timestamps in
the input to relative times, such as "15m5s ago". Many common timestamp
formats are supported. (Note that the `Time::Duration` and `Date::Parse` perl
modules are required for this mode to work. Currently, converting localized
dates is not supported.)

If both `-r` and a `format` is passed, the existing timestamps are
converted to the specified format.

If the `-i` or `-s` switch is passed, ts timestamps incrementally instead. In case
of `-i`, every timestamp will be the time elapsed since the last timestamp. In
case of `-s`, the time elapsed since start of the program is used.
The default format changes to "%H:%M:%S", and "%.S" and "%.s" can be used
as well.
