# Helper Libraries

> Helper libraries for administration tool development (mostly in bash).

This libraries may not be used stand-alone but are often needed within other scripts to make them work.

A short help is always included in the files but the [documentation](doc/README.md) section may have further information with usage examples for each library.

## Usage

If used in other git projects, it should be added as git submodule and included in the scripts uding relative paths. But don't forget to make it relative from the current script directory becausse the working directory may change depending from where the script is called. 

```bash
source_dir=$(dirname "${BASH_SOURCE[0]}")
source "$source_dir/bash-lib/colors"
```

But it can also be installed directly under `/opt` and included from your scripts with it's absolute path.
