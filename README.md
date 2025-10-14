# BASH-LIB Generation 2

This is the updated version of my personal library used to easily write powerful bash scripts which may work locally, partly remote or completely remote interactive or automatic.

> It is aimed to be used mainly under Debian like operation systems. But with some minor tweaks it should also wor on other Linux systems.

Version 2 is a complete rework of the library meaning it is another toolset and you could not upgrade to it.
Some functionalities from the older version will no longer be available like logging while a lot of new possibilities are included.

If you already use it jump directly to the [module description](https://gitlab.com/alinex/bash-lib/-/blob/master/doc/README.md).

## Architecture

It is a modular system where each file within the `bash-lib` folder contains a specific module with one or more functions which you load into your script. The file structure will look like:

```
bashlib/
    core            # only core functionality (minified)
    full            # file with full functionality (minified)
    loader          # same as full but including all source files
    base            # only the base/core functionality (minified)
    core/           # core modules which always be needed
    config/         # individual configuration
    modules/        # additional modules which can be optionally loaded
    install         # setup bashlib on this host
    update          # script to regenerate full file and docs after update 
    test            # run all unit tests
```

## Installation

Can be done locally after checking out the git repository manually by setting only the `BASHLIB_HOME` variable in your environment or directly from the repository by calling:

```bash
curl -sL https://gitlab.com/alinex/bash-lib/-/raw/master/install | bash                     # interactive
curl -sL https://gitlab.com/alinex/bash-lib/-/raw/master/install | bash -s -- <path> y|n    # automatic
```

The steps are:

1. Download bashlib to your system into a given path (directory will be created)
2. Setup BASHLIB_HOME in your environment in bashrc
3. Update configuration links to the directory above bashlib

The update will be the same, you only need to download the new files and overwrite the old ones.

## Usage

Your scripts will start with:

```bash
#!/usr/bin/env bash
source $BASHLIB_HOME/full           # to have all tools ready

source $BASHLIB_HOME/base           # to load only basics
source $BASHLIB_HOME/module/output  # and then single modules
```

## Configuration

The configuration should be put under `config/` folder and will be loaded in alphabetically order using:

```bash
source $BASHLIB_HOME/configs
```

The `config/` folder also contains some language files `lang.<xx>` which will be loaded if the shell is running in the appropriate `$LANG` to have multilingual output.

### Environment

There is a build in `DEBUG=1` flag, which you can set to do some specific debugging steps within the code. This is aimed to be used for development and bug fixing.

## Development

After updating the code you should rebuild the full version and documentation using:

```bash
./update
```

### Minimized library

The update will generate minimized files, if you use them and have an error you will not know there it is in the source module. To get the real source line better include the normal files using the loader:

```bash
$ ps-contracts 
/home/alex/dvb/scripts/local/bash-lib/full: Zeile 317: server ist nicht gesetzt.
$ source $BASHLIB/loader
$ ps-contracts
/home/alex/dvb/scripts/local/bash-lib/module/output: Zeile 12: server ist nicht gesetzt.
```

Keep in mind that for some remote execution of bash-lib the modular files are needed to transfer only the necessary part. So also if you use the minified version don't delete the others.

### Styleguide

- Variables intended for global use are in UPPER-CASE letters.
- Internal functions or variables start with an `_` to indicate not to use it in the script.
- Declare function variables as local.
- Comment usage of each function in comments before code.
- Test code below code to be enabled (see below).
- Use named arguments if there are more than a few.
- Use short names for functions but don't overwrite system commands if not intended.
- Each outside usable function and variable should have it's documentation just before the code.
- Each module contains a description as first comment line.
- Try to use simple bash tools instead of sed as often as possible to get better performance.
- The bash-lib itself is seldom used within itself.

### Test Code

Tests make the code base more stable. To also get this in bash we use [Bats](https://bats-core.readthedocs.io/) (Bash Automated Testing System).
To do so we write a test file beside the code. You can run the test within and see how it is used.

- https://github.com/ztombol/bats-support
- https://github.com/ztombol/bats-assert

> sudo apt install -y bats bats-support bats-assert

To run all tests call it with the folder:

```bash
$ bats local/bash-lib
_setup.bats
 ✓ input as arguments into line
 ✓ input from stdin into line

2 tests, 0 failures
```

Other possibilities to run the tests are:

- `bats local/bash-lib` - run all tests
- `bats local/bash-lib/_setup.bats` - run only tests in file
- `bats local/bash-lib --filter-tags input` - run only tests of given module or function
- `bats --show-output-of-passing-tests local/bash-lib` - to show the output of succeeded tests
- `DEBUG=1 bats --filter-tags mattermost local/bash-lib` - run in debug mode and display debug messages below result

As there are some **problems using bats with assoziative arrays and handling of exit** it could not completely test the whole framework. We tried other shell unit test tools but got no better result of bashunit or shellspec. So for the time being unit testing is only applied there possible.

### Quality Control

The library switches to `set -e` mode which will always exit a script if an unhandled error occur and this also if it is within a pipe so always handle these.

```bash
# load a file only if it is there
test -e $file && source $file       # bad
test ! -e $file || source $file     # better
# set variable to default if string is empty
test -z "$var" && var="default"     # bad
test -n "$var" || var="default"     # better
```

Also the use of undefined variables is prevented by using `set -u` therefore do something like below:

```bash
# forward $1 which may be undefined
echo "$1"       # bad
echo "${1-}"    # better always use this if the variable can be undefined
# check if variable is set
test -n "$t"        # bad 
test -n "${t-}"     # better
test -v t           # only >= Bash 4.2
```

### Debugging

First use `DEBUG=1` to run it to get the real file an line position on errors.

Next you can load the bash-lib directly into shell, but unset the exit on error, because it may close the shell:

```bash
source $BASHLIB_HOME/loader
set +e
```

Now you can run functions or the script line by line in the bash shell directly.
