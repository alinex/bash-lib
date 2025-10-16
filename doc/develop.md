# Developer Guide

> Keep in mind that this is a collection which may be incomplete and contain only essential information. Base knowledge of bash and the linux toolset as well as the additional linux packages is assumed to already be known or can be gathered on the net.

## Basic Workflow

After updating the code or language files you should rebuild it:

```bash
./update
```

This will:

- update the compressed code in `full` and `base`
- update the translation files (source/and binary)
- recreate the API Documentation

## Bug fixing

### Debug

The minimized/compressed files which you normally use like `full` and `base` will give you bad hints on error. It will show the source within the compressed file, not the source module. To fix this, run your script with the `loader` instead of the minimized files:

```bash
# Within the script the library will load like:
test -z "${DEBUG-}" && source "$BASHLIB_HOME"/full || source "$BASHLIB_HOME"/loader

# So you may call it in two ways
$ my-script 
/home/alex/dvb/scripts/local/bash-lib/full: Zeile 317: server ist nicht gesetzt.
$ DEBUG=1 my-script
/home/alex/dvb/scripts/local/bash-lib/module/output: Zeile 12: server ist nicht gesetzt.
```

Also the `DEBUG` mode will enable additional output which is invoked using the [`debug`](function/debug.md) function.

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

### Internationalization

This is done using the GNU gettext solution. All you have to do is to use it.

```bash
# Use simple text translation
gettext "Hello, world!"
# Output the same with a newline
echo "$(gettext "Hello, world!")"

# Use variables
name=Alex
printf "$(gettext "Hello, %s!")\n" "$name"
echo "$(eval_gettext 'Hello, $name!')"

# Pluralization based on count
count=2
echo "$(eval_ngettext 'An egg' '$count eggs' $count)"
```

After that you should:

1. Add translation entries in Code.
2. Run `update` to get them into the po/mo files.
3. Translate within `locale/<lang>/LC_MESSAGES/bashlib.po`
4. Run `update` again.

To support more languages add them to `$LOCALES` within the `update` script.
