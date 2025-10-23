# BASH-LIB Generation 2

This is the updated version of my personal library used to easily write powerful bash scripts which may work locally, partly remote or completely remote interactive or automatic.

> It is aimed to be used mainly under Debian like operation systems. But with some minor tweaks it should also work on other Linux systems.

Version 2 is a complete rework of the library meaning it is another toolset and you could not upgrade to it.
Some functionalities from the older version will no longer be available like logging while a lot of new possibilities are included.

Main Goals are:

- more modulare
- easier to use
- more features
- remote capabilities integrated
- unit tested and linted
- completely documented with examples

The downside may be:

- no backward compatibility - everything is new
- the logging library is not included (at the moment)
- needs bash v4.2 (February 2011)

If you already use it jump directly to the [module description](https://gitlab.com/alinex/bash-lib/-/blob/master/doc/README.md).

## Table of Contents

- [BASH-LIB Generation 2](#bash-lib-generation-2)
  - [Table of Contents](#table-of-contents)
  - [Architecture](#architecture)
    - [Quality](#quality)
    - [Version control](#version-control)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
    - [Environment](#environment)
  - [Latest Changes](#latest-changes)
  - [Contributing](#contributing)

## Architecture

It is a modular system with modules under: `core`, `config`, `module` and `extra`.
The file structure will look like:

```bash
bashlib/
    # combination to load precompressed or dynamically
    core            # only core functionality (minified)
    full            # file with full functionality (minified)
    loader          # same as full but including all source files
    base            # only the base/core functionality (minified)
    configs         # load all configurations
    # module directories
    core/           # core modules which always be needed
    config/         # individual configuration (dynamically loaded in full)
    module/         # additional modules but included in full
    extra/          # special modules which always  eb loaded individually
    # internal data
    locale/         # translations
    # tools to manage and develop bashlib
    install         # setup bashlib on this host
    update          # script to regenerate full file and docs after update 
    test            # run all unit tests
```

The BashLib will be installed on the System with it's `BASHLIB_HOME` directory in the environment to let the scripts find it and load what they need.

### Quality

The modules are as far as possible unit tested (using bats) and analyzed by the shellcheck static analysis and linting.
Documentation of externally usable variables and functions is completely done inline and exported as markdown documentation.

### Version control

In the moment it doesn't use fixed version numbers or release plans, use the git tags or date therefore. Also a changelog is not maintained separately, see the commit history therefore. That's because it is a side project and I minimize the effort to maintain it.

## Installation

Can be done locally after checking out the git repository manually by setting only the `BASHLIB_HOME` variable in your environment or directly from the repository by calling:

```bash
curl -sL https://gitlab.com/alinex/bash-lib/-/raw/master/install | bash     # interactive
curl -sL https://gitlab.com/alinex/bash-lib/-/raw/master/install | \
    bash -s -- "<path>" y|n "<config>"                                      # automatic
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
```

The optimal solution may to use the `full` or `loader` (based on `DEBUG` mode locally:

```bash
#!/usr/bin/env bash
test -z "${DEBUG-}" && source "$BASHLIB_HOME"/full || source "$BASHLIB_HOME"/loader
```

And for the scripts better use the individual loading if not so much is needed:

```bash
#!/usr/bin/env bash
source $BASHLIB_HOME/base           # to load only basics
source $BASHLIB_HOME/module/output  # and then single modules
source $BASHLIB_HOME/configs        # load configuration
```

For further assistance see the [Examples](./README.md#Examples) within the Modules API documentation.

A [bash short reference](./bash-reference.md) is also available here.

## Configuration

The configuration should be put under `config/` folder and will be loaded in alphabetically order in `full` or by using:

```bash
source $BASHLIB_HOME/configs
```

The `config/` folder also contains some language files `lang.<xx>` which will be loaded if the shell is running in the appropriate `$LANG` to have multilingual output.

### Environment

There is a build in `DEBUG=1` flag, which you can set to do some specific debugging steps within the code. This is aimed to be used for development and bug fixing.

Ideally you will also switch to use the loader from your script if `DEBUG` is set:

```bash
test -z "${DEBUG-}" && source "$BASHLIB_HOME"/full || source "$BASHLIB_HOME"/loader
```

## Latest Changes

This will be shown in our [changelog](./CHANGELOG.md).

## Contributing

👋 Welcome, and thank you for your interest in contributing to **BashLib 2**!  
We’re happy you’re here — whether you’re adding new ideas, make a translation, fixing bugs, improving scripts, or adding new utilities.

Please have a look at the [contributing page](./CONTRIBUTING.md).
