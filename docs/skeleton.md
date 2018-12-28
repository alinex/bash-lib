# Skeleton

The skeleton is used as a base to make your own script. Use it as template, copy it and fill in your specific program parts.

The most common parts like configuration, bash-lib loading and options checker are
already included.

```bash
#!/bin/bash

# Script to....
#
# Usage: skeleton <params>
#
# The skeleton is used as a base to make your own scripts.

# Include library
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/../lib/base.bash"

# Configuration
LOG_LEVEL=DEBUG
LOG_FILE=${LOG_FILE:-$(path)/../log/$(basename $0).log}

# If you also work in gitlab with release tags
VERSION=$(git describe --abbrev=0 --tags 2>/dev/null)
VERSION=${VERSION:-master} # use master if not defined
REVISION=$(git rev-parse --verify master)
GITLAB=$(git config --get remote.origin.url | sed 's/\.git$//')

# Parameter checking
parsed=$(getopt --options=:Vh --longoptions=version,help --name "$0" -- "$@")
[ ${PIPESTATUS[0]} -eq 0 ] || log_exit "Could not parse parameters!"
eval set -- "$parsed"
while true; do
    case "$1" in
        -V|--version) echo "$(basename $0) version $VERSION"; exit 0 ;;
        -h|--help) source "$(path)/$(basename $0).help"; exit 0 ;;
        --) shift; break ;;
        *) break ;;
    esac
done
[ $# -gt 0 ] \
&& log WARN "No parameters are supported, only -h to show help - ignoring them"

# change into command directory
cd "$(path)"

# Processing





log NOTICE Done.
```

Copy this code and change it to your specification and add the processing...
