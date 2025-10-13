# Base Script

The script should always start including the BashLib:

```bash
#!/usr/bin/env bash
source $BASHLIB_HOME/full           # to have all tools ready
```

Next in the script is the argument parsing and command help:

```bash
TITLE="Test Script"
USAGE="$(basename $0) [<options>] <instance>"
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
        -n|--name)  name="$2"; shift 2 ;;
        -a|--age)   age="$2"; shift 2 ;;
        -h|--help)  help "$TITLE" "$USAGE" "$OPTIONS" "$DESCRIPTION"; shift ;;
        --) shift; break ;;
        *) die "Unerwartete option: $1" ;;
    esac
done
num_parameters "$@" --min 1 --max 1 --die "Falsche Anzahl Parameter: $USAGE"
```

Then your real script may begin...
