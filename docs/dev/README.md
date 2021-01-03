# Design Decisions

The bash library is build on a flat architecture. Some libraries needs each other and will be combined together on [build](build.md).

## Directory Structure

The following folders are used:

    bin             # development helper commands
    src             # source code:
        bin         # - commands
        include     # - libraries
    test            # test methods
    docs            # documentation
    dist            # distribution folder
    site            # created documentation

And the core configuration files are:

    README.md       # short info
    mkdocs.yml      # config for documentation
    .gitlab-ci.yml  # continuous integration setup

## File Structure

The library files have the same structure.

First the necessary base libraries should be loaded. For direct execution this should be done from the current directory which is retrieved in `source_dir`:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/colors.bash" # load color methods
```

Keep in mind that `source_dir` may change within a library and both lines will also be removed while [building](build.md) the packages. If you need the directory later better use the method `$(path)` which is in the base library and gives you the same path.

The next part always is the configuration section. This includes:

-   definition of internal variables
-   checking of preset environment settings

After maybe some one time pre-processing is done the real methods will follow.

### Methods

Each method should at first check all parameters for valid arguments and store the results.

On misconfiguration, improper calls or system problems the command should be stopped using `log_exit ALERT <message>`.

The results will be written as text to `STDOUT`. This allows to pipe them into file or other commands. The exit code have to be `0` if everything succeeds.

## Languages

While the bash library is mainly written in bash itself, some more complex operations are done by perl scripts which includes seamlessly into the library.

## System Tools

Some of the default unix tools are used like:

-   `grep` to match lines
-   `tail` and `head` to extract part of the strings
-   `sed`, `awk` or `perl` to match or replace parts
-   and a lot of other default linux utils

But this should neither be a problem because all of them are base tools and already installed.

{!docs/assets/abbreviations.txt!}
