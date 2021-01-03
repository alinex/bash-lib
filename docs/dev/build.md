# Build Process

To generate the compressed and combined packages a build process is available. 
By calling `bin/build` from within the project directory the distribution will be build. This will:

- check that everything is checked in and pushed to master
- build libraries
  - add header
  - remove comments and unnecessary white-space
  - remove library includes (not needed in combined packages)
  - set `VERSION`, `REVISION`, `GITLAB` to fixed values
  - pack them together by concatenation
- build commands
  - add header
  - remove comments and unnecessary white-space in bash files
  - include libraries in bash files
  - set `VERSION`, `REVISION`, `GITLAB` to fixed values

The result will be stored in the distribution folder `dist`. This folder will hold the files you may use later.

The `dist` folder contains the combined libraries, described below:

    -rw-rw-r-- 1 alex alex  9994 Nov  9 08:11 base.bash
    -rw-rw-r-- 1 alex alex 10970 Nov  9 08:11 psql.bash
    -rw-rw-r-- 1 alex alex 11603 Nov  9 08:11 locking.bash
    -rw-rw-r-- 1 alex alex 13350 Nov  9 08:11 info.bash
    -rw-rw-r-- 1 alex alex 15935 Nov  9 08:11 all.bash

And also some commands (without extension):

    -rwxrwxr-x 1 alex alex   549 Nov  9 08:23 log
    -rwxrwxr-x 1 alex alex 79640 Nov  9 08:23 sendmail

> All files are self contained, so you only pick the ones you need. They are also slightly
> compressed for better load time.

## Setup

Which libraries to build into which packages is configured within the [build script](https://gitlab.com/alinex/bash-lib/blob/master/bin/build):

```bash
lib[base]="core, colors, log"
lib[process]="core, colors, log, process"
lib[info]="core, colors, log, info"
lib[psql]="core, colors, log, psql"
lib[all]="core, colors, log, process, info, psql"
```

While the associative array `lib` contains all packages, each package contains a comma separated list of libraries.

To include a library within a command put a comment exactly like below in the code:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))

# DIST include base.bash
source "$source_dir/../include/log.bash" # load log handler
```

That will directly include the `base.bash` at the position of this comment and remove the line behind which is the `source` line.

### Variable replacement

The following variables will be replaced by their values in build process:

In bash:

-   `VERSION=...`
-   `REVISION=...`
-   `GITLAB=...`

In Perl:

-   `###VERSION###`
-   `###REVISION###`
-   `###GITLAB###`

{!docs/assets/abbreviations.txt!}
