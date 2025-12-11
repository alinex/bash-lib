# die

## Output error message and exit

### Usage

```bash
die <message>
<message> | die
```

### Error (stderr)

# Example if called for deprecated call:

```
DEPRECATED: ask_input at task_find in /home/alex/bin/dvb/cleanup:206 please use ask string
> _stacktrace          at die() in /home/alex/dvb/bash-lib/core/misc:59
> _stacktrace          at _deprecated() in /home/alex/dvb/bash-lib/core/internal:23
> _stacktrace          at ask_input() in /home/alex/dvb/bash-lib/module/input:150
> _stacktrace          at task_find() in /home/alex/bin/dvb/cleanup:206
> _stacktrace          at tasks() in /home/alex/dvb/bash-lib/module/input:451
> _stacktrace          at main() in /home/alex/bin/dvb/cleanup:364
```

### Return (exit code)

- always 1 and try to exit script with status 1
- 
