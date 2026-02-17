# Contributing to BashLib 2

👋 Welcome, and thank you for your interest in contributing to **BashLib 2**!  
We’re happy you’re here — whether you’re adding new ideas, make a translation, fixing bugs, improving scripts, or adding new utilities.

This document outlines the process and best practices for contributing to the project.

## Table of Contents

- [Contributing to BashLib 2](#contributing-to-bashlib-2)
  - [Table of Contents](#table-of-contents)
  - [Users](#users)
    - [🐞 Reporting Bugs](#-reporting-bugs)
    - [🌟 Suggesting Features](#-suggesting-features)
    - [🌐 Translations](#-translations)
    - [📚 Extend and Update Documentation](#-extend-and-update-documentation)
  - [Developers](#developers)
    - [📦 Fork, Clone and Merge Requests](#-fork-clone-and-merge-requests)
    - [🛠️ Setup Environment](#️-setup-environment)
    - [🔍 Debugging](#-debugging)
    - [🌐 Internationalization](#-internationalization)
    - [📋 Run Unit Tests](#-run-unit-tests)
      - [Local run](#local-run)
      - [Docker based Tests](#docker-based-tests)
      - [Manual Docker run](#manual-docker-run)
      - [CI Run in GitLab](#ci-run-in-gitlab)
    - [📝 Linting with Shellcheck](#-linting-with-shellcheck)
    - [🧹 Code Guidelines](#-code-guidelines)
    - [🚫 Deprecation](#-deprecation)
    - [📚 Documentation](#-documentation)
    - [🏁 Finalize](#-finalize)
  - [❤️ Thank You](#️-thank-you)

## Users

We will keep this as simple as possible for you. So we allow to contribute in this segment completely without git knowledge. The only thing you need is to register for free on GitLab to make the issues.

### 🐞 Reporting Bugs

Found a bug?  
Please open an [Issue](https://gitlab.com/alinex/bash-lib/-/issues) and include:

- A clear description of the problem
- Steps to reproduce
- Expected vs. actual behavior
- Your OS, Bash version and environment

Example:

```text
**Describe the bug**
`lib_join` fails when input contains spaces.

**To Reproduce**
lib_join "," "a b" "c"

**Expected**
"a b,c"

**Actual**
"a,b,c"

**Environment**
- Ubuntu 24.04
```

### 🌟 Suggesting Features

Have an idea to improve BashLib?  
Open an [Issue](https://gitlab.com/alinex/bash-lib/-/issues) with:

- The problem your feature solves
- A short example of how it might be used
- Any relevant implementation notes

We’ll discuss and decide together before coding starts.

### 🌐 Translations

At the moment we have only two languages:

- [en](https://gitlab.com/alinex/bash-lib/-/raw/master/locale/en/LC_MESSAGES/bashlib.po?ref_type=heads&inline=false) - the original english translation
- [de](https://gitlab.com/alinex/bash-lib/-/raw/master/locale/de/LC_MESSAGES/bashlib.po?ref_type=heads&inline=false) - for german translation

You can help translating these. If you are not familiar with git simply copy the files linked above, change the translation in the `msgstr` entries and resend the file in a new [Issue](https://gitlab.com/alinex/bash-lib/-/issues):

```bash
#: module/input:49 module/input:74 module/input:178
msgid "Disallowed answer"
msgstr "Ungültige Antwort"
```

> In the english file you should only add an `msgstr` there you want to optimize the english. If it is correct let it empty.

If you are familiar with git, you may work with [fork and clone](#fork-clone-and-merge-requests), change `locale/<lang>/LC_MESSAGES/bashlib.po` and make an merge request to integrate it.

And finally to have a new language open an [Issue](https://gitlab.com/alinex/bash-lib/-/issues) and we will provide the template to translate for you.

### 📚 Extend and Update Documentation

If you can help here, please do so and help us with:

- typo errors
- misunderstandings
- improvements to the documentation in any way
- more or better examples

> I am not an native speaker so there may be some room to optimize 😉

You can send in your changes in an [Issue](https://gitlab.com/alinex/bash-lib/-/issues) containing the link there to put it.

## Developers

To help you getting started and keeping you in track for a fluent work we have collected some useful information.

After contributing in a bigger part we will also consider to make you part of the team and give you write access to this project and mentioning you as co developer if you want.

### 📦 Fork, Clone and Merge Requests

To contribute to BashLib is the dame as to any other GitLab repository.

1. **Fork** this repository

   Go to the [GitLab project page](https://gitlab.com/alinex/bash-lib).\
   Click “Fork” (usually top right).\
   Choose your namespace (your account or a group).\
   GitLab will create a copy of the repo under your account.

   Your fork’s URL will look like this:
   `https://gitlab.com/<your-username>/bash-lib`

2. **Clone** your fork locally:

   In your terminal:

   ```bash
   git clone https://gitlab.com/<your-username>/bash-lib.git
   cd bash-lib
   ```

3. **Add original as upstream** (optional but useful):

   This lets you pull future updates from the original repo:

   ```bash
   git remote add upstream https://gitlab.com/alinex/bash-lib.git
   ```

   Check remotes:

   ```bash
   git remote -v
   ```

   You should see:

   ```text
   origin   https://gitlab.com/<your-username>/bash-lib.git (fetch)
   upstream https://gitlab.com/alinex/bash-lib.git (fetch)
   ```

4. **Create a new branch** for your work:

   Best to make your changes in a separate branch.

   ```bash
   git checkout -b feature/my-new-feature
   ```

5. **Make your changes**

   Edit code, add files, etc.\
   Test and check it.

   Then stage and commit:

   ```bash
   git add .
   git commit -m "Add new feature: X"
   ```

6. **Push your branch** to your fork:

   ```bash
   git push origin feature/my-new-feature
   ```

7. **Create a Merge Request** (MR) in GitLab:

   Go to your fork on GitLab (e.g., `https://gitlab.com/<your-username>/bash-lib`).

   You’ll see a prompt like “Create merge request” — click it.

   Make sure:

   - Source branch: your fork’s feature/my-new-feature
   - Target branch: the original repo’s develop branch [gitlab.com/alinex/bash-lib/-/tree/develop](https://gitlab.com/alinex/bash-lib/-/tree/develop)
   - Add a title, description, and any reviewers.
   - Submit the MR 🎉

8️. **Keep your fork up to date** (optionally)

   If the original repo updates:

   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   git push origin main
   ```

We’ll review your PR, run CI checks, and merge once approved ✅

### 🛠️ Setup Environment

Before making changes, please make sure your environment includes:

- **Linux Operating System** we use Debian/Ubuntu
- **bash** ≥ 4.2

You should also install:

- **bats-core** for testing → [github.com/bats-core/bats-core](https://github.com/bats-core/bats-core)  
- **bats-support** for testing → [github.com/ztombol/bats-support](https://github.com/ztombol/bats-support)
- **bats-assert** for testing → [github.com/ztombol/bats-assert](https://github.com/ztombol/bats-assert)
- **shellcheck** for linting → [www.shellcheck.net/](https://www.shellcheck.net/)
- **gettext** for localization -> [www.gnu.org/software/gettext/](https://www.gnu.org/software/gettext/)

As IDE we use VS Code with the Extensions:

- Bash IDE
- Bats
- gettext
- Markdown All in One
- markdownlint
- ShellCheck

### 🔍 Debugging

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

```bash
debug "calling xxx" # will be printed in any debug mode
debug 3 "curl...."  # will only show with `DEBUG=3` or higher
```

Level 9 is highest and will show all.

But you can also select only specific functions to debug by specifying a function pattern or list so your possibilities to debug are:

- `DEBUG=` to not debug
- `DEBUG=1` for minimal debugging
- `DEBUG=5` with stack traces on die
- `DEBUG=6` with stack traces also with code view
- `DEBUG=9` for maximal debugging
- `DEBUG=curl` to only debug one function
- `DEBUG=curl,remote` for multiple functions

Further on, you can send stacktraces using `_stacktrace` which will be output as `DEBUG=5`.

```text
> _stacktrace          /home/alex/dvb/bash-lib/core/validator:76 (is)
> _stacktrace          scripts/_test:33 (main)
```

And with code example using `DEBUG=6`:

```text
> _stacktrace          /home/alex/dvb/bash-lib/core/validator:76 (is)
> _stacktrace            74: -n | --name) name="$2" && shift 2 ;;
> _stacktrace            75: -s | --sanitize) sanitize=1 && shift ;;
> _stacktrace            76: --min) [[ "$2" =~ ^-?[0-9]+$ ]] && min="$2" && shift 2 || die "$(printf "$(gettext "Parameter %s needs integer")" min)" ;;
> _stacktrace            77: --max) [[ "$2" =~ ^-?[0-9]+$ ]] && max="$2" && shift 2 || die "$(printf "$(gettext "Parameter %s needs integer")" max)" ;;
> _stacktrace            78: --) shift && break ;;
> _stacktrace          scripts/_test:33 (main)
> _stacktrace            31: ################################################################################################
> _stacktrace            32: 
> _stacktrace            33: is integer 5.27k --sanitize --min=o
```

If you could not find the Problem in `DEBUG` mode, you can load the bash-lib directly into shell, but unset the exit on error, because it may close the shell:

```bash
source $BASHLIB_HOME/loader
set +e
```

Now you can run functions or the script line by line in the bash shell directly.

### 🌐 Internationalization

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

### 📋 Run Unit Tests

Tests make the code base more stable. To also get this in bash we use [Bats](https://bats-core.readthedocs.io/) (Bash Automated Testing System).
To do so we write a test file beside the code.

#### Local run

To use `bats` first install it by running: `sudo tests/setup/bats`

To run all tests call it with the folder:

```bash
$ bats core
arguments.bats
 ✓ input: as arguments into line
 ✓ input: from stdin into line
 ✓ input_args: as arguments into line
 ✓ input_args: from stdin into line
 ✓ input_lines: as arguments into lines
 ✓ input_lines: from stdin into lines
 ✓ option_parse: parse example specification
 ✓ option_parse: options at the end
 ✓ option_parse: multiple short options together
 ✓ option_parse: put name and value together
 ✓ option_parse: with short spec
 ✓ option_parse: without short name
 ✓ option_help: print options from example specification
date.bats
 ✓ now: should get timestamp
 ✓ date_diff: should get difference of timestamps
 ✓ date_diff: should get difference of date strings
 ...

52 tests, 0 failures
```

Other possibilities to run the local tests are:

- `bats core module extra` - run all tests
- `bats core/date.bats` - run only tests in file
- `bats core --filter-tags input` - run only tests of given module or function
- `bats core --show-output-of-passing-tests` - to show the output of succeeded tests
- `DEBUG=1 bats core --filter-tags mattermost` - run in debug mode and display debug messages below result

> As there are some **problems using bats with assoziative arrays and handling of exit** it could not completely test the whole framework. We tried other shell unit test tools but got no better result of `bashunit` or `shellspec`. So for the time being unit testing is only applied there it is possible, but that's most of the functions.

#### Docker based Tests

Next step should be to run the tests on different operating systems. Therefor we use `docker` so have your environment running and accessible under your user.

```bash
$ ./test
Running multiple OS using local docker
Debian 11 (docker.io/library/debian:11) 1..36
not ok 26 debug: show level 1
# tags: debug misc
# (from function `assert' in file bats-assert/src/assert.bash, line 40,
#  in test file core/misc.bats, line 24)
#   `assert [ "$(uncolorize "$output")" = "> run                  Test" ]' failed
#
# -- assertion failed --
# expression : [ > bats_merge_stdout_and_stderr Test = > run                  Test ]
# --
#
Debian 12 (docker.io/library/debian:12) 1..36
Debian 13 (docker.io/library/debian:13) 1..36
...
```

> You see the output how it will look if one test in debian 11 fails.

You can also selectively run only one os type yb giving this a argument or a specific version. The names should be equal to the image name:

```bash
./test debian        # Test all valid debian versions
./test debian 12     # Test only Debian 12
```

#### Manual Docker run

First run a shell within the docker image (my home directory is added here, because of the test-config which is needed):

```bash
docker run --rm -it -v ".:/mnt" -v "/home/alex:/home/alex" -w /mnt "redhat/ubi8" sh
```

Now you have to setup for BashLib with the correct OS type:

```bash
. tests/setup/docker-redhat
```

ANd then you can run the tests like locally:

```bash
bats core module
```

#### CI Run in GitLab

Sorry, we had to remove this because it takes to much time in the free GitLab plan to run all the tests.

### 📝 Linting with Shellcheck

To use the shellcheck static analysis and linting tool also within the scripts you have to install [ShellCheck Plugin](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck) for VS Code.

With the following setup:

- Exclude: SC1134 SC1072 SC1073
- Use Workspace Root As Cwd: Yes

Then you need to setup at least the bashlib path as source in `.shellcheckrc` in your project root:

```bash
# Search paths for scripts
source-path=SCRIPTDIR
source-path=/home/alex/dvb/bash-lib
# Enable following all sourced files
external-sources=true
# Enable selected optional checks
enable=quote-safe-variables
enable=check-unassigned-uppercase
# Disable specific warnings
disable=SC1072,SC1073,SC1134
```

### 🧹 Code Guidelines

Your code should:

- Use `#!/usr/bin/env bash`
- Avoid unnecessary external commands (`sed`, `awk`, etc.) where built-ins suffice
- Quote all variables unless explicitly required otherwise
- Prefer lowercase function names with underscores: `my_function()`
- Variables intended for global use are in UPPER-CASE letters. Often also used to externally set them as environment.
- Only internal functions or variables start with an `_` to indicate not to use it in the script.
- Function variables should be declared as local.
- Use options if there are more than a few arguments. The options should be in long form with an additional `=` sign for readability.
- Use short names for functions but don't overwrite system commands if not intended.
- Each module contains a description as first comment line.
- Full documentation using comments directly before the function or variable.
- Try to use simple bash tools instead of sed as often as possible to get better performance.
- The bash-lib itself is seldom used within itself to make the internal dependency level low.
- Make all output translationable but not the debug messages.

**Best Practice examples:**

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

As far as possible use bash internal variable optimization:

```bash
pattern="$(echo "$1" | sed 's/ /|/g')"  # bad
pattern="${1// /|}"                     # better
```

### 🚫 Deprecation

As the library progresses, it will change and sometimes older functions are replaced or removed. Therefor we use three steps:

1. **Mark as deprecated:**
   Here we only add the `_deprecated` warning with `warn` as second parameter to only show the message but go on in the program. As the replacement function will work identical in the example below we directly call it. And we show the deprecation in the documentation.

      ```bash
      # Deprecated: Remote install package like @install
      # Use `remote_bashlib software install`, see @remote_bashlib.
      remote_install() {
         _deprecated "use remote_bashlib software install" warn
         remote_bashlib software install
      }
      ```

2. **Later we will break on a call:**
   So if it is used the deprecation warning will be displayed and the process will stop. That is done without the `warn` flag, the code and documentation removed. Now to work again the calling script has to be changed.

      ```bash
      remote_install() {
         _deprecated "use remote_bashlib software install"
      }
      ```

3. **And in the last step we clean up:**
   The method will be completely be removed.

We try to always show the deprecation for a longer time and let it work. The step from (1) to (2) should be done on at least a minor version change. The same goes for the change from (2) to (3).\
The goal is to keep the code clean and short.

### 📚 Documentation

The markdown documentation within [doc](doc) is partly generated automatically from code:

- doc/example contains manually written examples
- doc/function is completely generated out of code - do not change here
- doc/README.md has a first manual Part but starting with the modules everything will be aut generated

To write documentation in the code you should:

Add a description of each module file, as first comment part after a newline in the file like:

```text
#!/usr/bin/env bash
# shellcheck disable=SC2034
# shellcheck source=base
source /dev/null
# shellcheck source=config/environment
source /dev/null

# Module with operating system specific helper functions. THIS IS THE MODULE DESCRIPTION

######################################################################################
### Detect OS / Hardware
######################################################################################

declare -A _os_detected
....
```

Further the short comment directly before a public variable is added in the index:

```text
# Array: Color limits per mount (regex critical error warn ok) used in @df
MOUNT_COLOR_LIMIT="${MOUNT_COLOR_LIMIT:=('.*' 100 90 80 50)}"
```

The same goes for the function, but here you can write a big comment block with all information to generate a separate page for it:

```text
# Get sudo information
#
# This lists all allowed sudo commands for the user.
#
# Usage:    sudo_info [<user>]...
# Output:   <tsv with header>
#
#           ```text
#           User     UID    GID     command
#           alex     ALL            /usr/bin/openfortivpn
#           alex     ALL    ALL     ALL
#           ```
```

The first line will be used as short description in the index and heading of the page.

Lines starting with a keyword will be used specific description parts and the indention will be removed:

- `Usage` - short usage text, maybe multiple lines -> displayed as **pre formatted** text box
- `Option(s)` - list of options -> displayed as **pre formatted** text box
- `Variable(s)` - used external variables -> **markdown** (mostly as list)
- `Global(s)` - global variables like configuration settings -> **markdown** (mostly as list)
- `File(s)` - files which were read or written -> **markdown** (mostly as list)
- `TTY` - input and output -> **markdown**
- `Output` - through STDOUT -> **markdown**
- `Error(s)` - through STDERR -> **markdown**
- `Return(s)` - return value on specific conditions -> **markdown** (list)
- `Tool(s)` - special tools used which have or will be installed -> **markdown** (list)
- `Example(s)` - link to examples using  -> **markdown** (mostly as list)

Everywhere in the markdown you can use:

- `<name>` which are written as monospace symbols
- `$xxx` which are written as monospace symbols (variables)
- `@xxx` will link to the help page for the named function
- `@xxx[ command]` add the text in brackets to the link text
- `&xxx` will link to `example/xxx.md`
- `&xxx[ command]` add the text in brackets to the link text

### 🏁 Finalize

After updating the code, documentation or language files you should rebuild it:

```bash
./update
```

This will:

- update the compressed code in `full` and `base`
- update the translation files (source/and binary)
- recreate the API Documentation

> If you run in `DEBUG` mode with the loader you don't need to run the update to test the changes.

## ❤️ Thank You

Please treat everyone with respect and professionalism.

Your contributions make **BashLib2** stronger, more reliable, and more fun to use. \
We truly appreciate your help! 🙌
