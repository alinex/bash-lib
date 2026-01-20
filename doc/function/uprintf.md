# uprintf

## Unicode-aware printf variant for multibyte characters.

### Usage

```bash
printf <pattern> [<value>]...
```

### Description


This works exactly like printf, but should be used if width calculation is needed like in `%15s`. Instead of counting bytes (which the original printf does) this variant uses `awk` under the hood to count characters.
Therefor it will also make the alignment correct for german Umlaut or other multibyte Unicode characters. But it will not work for all the Unicode symbols and emojis.


