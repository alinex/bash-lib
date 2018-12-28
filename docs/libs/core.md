# Core

This part of the bash lib contains some general helper methods which are not suitable
to be put in other lib parts.

## path

Get the absolute path to the called script. It's the same as `$source_dir` which is used in the general examples but this stays the same while the variable may be changed in scripts.

```bash
# load the help file shich will output help pages directly beside the script
source "$(path)/$(basename $0).help"
```

It is always the directory path of the first called script which included the libraries.
