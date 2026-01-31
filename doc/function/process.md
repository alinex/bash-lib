# process

## Process control

### Usage

```bash
process info <pid>|<string>     # show summary for all matching processes
process list <pid>|<string>     # show list of process groups (one summary per group) as tsv
process tree <pid>|<string>     # show process trees
process wait [<options>] <pid>|<string>
process kill <pid>|<string> [<signal>]
```

### Options

```bash
-w, --watch        # (for wait) watch health status till done
-t, --timeout      # (for wait) end with
```

### Output (stdout)

- info: human readable line
- list/tree: tsv with header


### Description


This function will work on the main pid for the matching process groups:

- if a `<pid>` is given the top parent of this is used
- if a name is given matching process groups in name or path are searched and their top parents are used

