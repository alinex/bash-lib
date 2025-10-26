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
    - [📝 Linting with Shellcheck](#-linting-with-shellcheck)
    - [🧹 Code Guidelines](#-code-guidelines)
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
`blib_join` fails when input contains spaces.

**To Reproduce**
blib_join "," "a b" "c"

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
   - Target branch: the original repo’s main https://gitlab.com/alinex/bash-lib.git
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

- **bats-core** for testing → [https://github.com/bats-core/bats-core](https://github.com/bats-core/bats-core)  
- **bats-support** for testing → https://github.com/ztombol/bats-support
- **bats-assert** for testing → https://github.com/ztombol/bats-assert
- **shellcheck** for linting → [https://www.shellcheck.net/](https://www.shellcheck.net/)
- **gettext** for localization -> https://www.gnu.org/software/gettext/

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
- `DEBUG=9` for maximal debugging
- `DEBUG=curl` to only debug one function
- `DEBUG=curl,remote` for multiple functions

Further on, you can send stacktraces using `_stacktrace` which will be output as `DEBUG=5`.

```text
> _stacktrace          Stack trace (most recent call last):
> _stacktrace            at main() in /home/alex/bin/dvb/_test:32
> _stacktrace            at timer_start() in /home/alex/dvb/bash-lib/core/date:169
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

Other possibilities to run the local tests are:

- `bats local/bash-lib` - run all tests
- `bats local/bash-lib/_setup.bats` - run only tests in file
- `bats local/bash-lib --filter-tags input` - run only tests of given module or function
- `bats --show-output-of-passing-tests local/bash-lib` - to show the output of succeeded tests
- `DEBUG=1 bats --filter-tags mattermost local/bash-lib` - run in debug mode and display debug messages below result

As there are some **problems using bats with assoziative arrays and handling of exit** it could not completely test the whole framework. We tried other shell unit test tools but got no better result of `bashunit` or `shellspec`. So for the time being unit testing is only applied there possible.

Next step should be to run the tests on different operating systems. Therefor we use `docker` so have your environment running and accessible under your user.

```bash
./test
```

And the last test will be within the build pipeline after submitting something to gitlab.com.

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

### 🏁 Finalize

After updating the code or language files you should rebuild it:

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
