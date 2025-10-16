# Base Script

The script should always start including the BashLib:

```bash
#!/usr/bin/env bash
# shellcheck source=base disable=SC2015
test -z "${DEBUG-}" && source "$BASHLIB_HOME"/full || source "$BASHLIB_HOME"/loader
```

> Use `#!/usr/bin/env bash` because it is more portable than direct bash path. The env command locates bash in your system’s PATH, so the script works regardless of where bash is installed. For example, on some systems, bash might be in `/bin/bash`, on others in `/usr/bin/bash`, or even `/usr/local/bin/bash`.

> Next line 2 is only needed if you use shellcheck also within your script.

> The last line is the only thing you really need specifically to use the BashLib. If the BashLib is correctly installed it will find it and select the `full` (compressed code) or `loader` (all modules dynamically) if run in `DEBUG` mode.

Next you may have some argument parsing and validation:

```bash
TITLE="Test Script"
USAGE="$(basename "$0") [<options>] <instance>"
OPTIONS="
n name  string  Name of Birthday Person
a age   int     Age in years
h help  -       Show Help Page"
DESCRIPTION=\
"Beispiele:
- test-script
- test-script middleware-1.host.user.dvb
"
# parse and validate arguments
eval set -- "$(option_parse "$OPTIONS" "$@")"
while true; do
    case "$1" in
    -n|--name)  
        name="$2"
        shift 2
        ;;
    -a|--age)   
        age="$2"
        shift 2
        ;;
    -h|--help)  
        help "$TITLE" "$USAGE" "$OPTIONS" "$DESCRIPTION"
        shift
        ;;
    --) 
        shift
        break
        ;;
    *)  die "Unerwartete option: $1"
        ;;
    esac
done
num_parameters --min 1 --max 1 \
    --die "Falsche Anzahl Parameter: $USAGE" \
    -- "$@"

header "$TITLE"
```

> At least the `help` option should always be there.

Then your real script may begin...
You can work with the additional arguments in `$1`...
