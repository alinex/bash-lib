title: Usage

# Bash Library

This is a collection of helper programs and libraries for administration tool development (mostly in bash). The complete library is build into combined packages, which mostly can be added as single include file to work.

This documentation will show you how to use them.

## Installation

Mostly you won't install the bash-lib on a server but create some scripts based on it. But that won't mean you can't or you shouldn't do so. As always it depends on your needs.

> See the following chapter for all the possibilities to use it.

First copy the full distribution package or only the parts you need standalone or within your application onto a server. See the [downloads page](downloads) for the latest releases.

!!! info "Standalone Installation"

    For a standalone installation move the complete distribution to the to a central position and use it from there. This will often be in `/opt/bash-lib` and should also be included in the path for the standalone commands to be used:

        wget https://alinex.gitlab.io/bash-lib/downloads/bash-lib.tgz
        tar -xzvf bash-lib.tgz
        cp dist /opt/bash-lib
        echo "PATH=\"$PATH:/opt/bash-lib\"" >> ~/.bashrc

    But you can also always copy the command directly to any other folder and use it from there.

Some of the commands needs additional helpers, which are not always installed on your server. To check if you have everything working run the checker once directly on your server:

    curl https://alinex.gitlab.io/bash-lib/downloads/install | bash

This will give you information what is needed and if possible automatically installs the needed packages.

### Including libraries

The most common way is to include the needed library from the [release packages](downloads) within the destination code. That ensures that changes to the bash-lib repository or a central installation won't change the running code. You can update it yourself anytime you want to by overwriting it with a newer version.

As already said, all files are self contained without further references. So copy the needed library as `lib.bash` to your project and include it relatively:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/lib.bash"
```

You can also pick the files directly from the [complete distribution](https://alinex.gitlab.io/bash-lib/downloads/bash-lib.tgz) or add all of them, it's very small.

### Short usage

To only use it in single bash script, put the library directly beside your script:

```bash
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
source "$source_dir/base.bash"

# here you can use it
```

> See also the following [Skeleton](skeleton.md) which gives you a fast start for your own script.

### Install and Use

If you want to run a script with the bash lib but don't know if it is already installed, you can always check and install before you use it automatically:

```bash
# load bash lib or use alternative log method
log() { echo $2; }
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
if [ -e "$source_dir/lib/base.bash" ]; then
    source "$source_dir/lib/base.bash"
else
    # update bash lib
    log INFO "Installing bash-lib..."
    rm -rf "$source_dir/lib"
    curl -s https://alinex.gitlab.io/bash-lib/downloads/bash-lib.tgz | tar -xz
    mv dist "$source_dir/lib"
    source "$source_dir/lib/base.bash"
fi
```

And if you want to always update it to the newest version use:

```bash
# load bash lib or use alternative log method
log() { echo $2; }
source_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]:-$(pwd)/x}"))
if [ -e "$source_dir/lib/base.bash" ]; then
    source "$source_dir/lib/base.bash"
fi
# update bash lib
log INFO "Updating bash-lib..."
rm -rf "$source_dir/lib"
curl -s https://alinex.gitlab.io/bash-lib/downloads/bash-lib.tgz | tar -xz
mv dist "$source_dir/lib"
source "$source_dir/lib/base.bash"
```

## Download PDF or ePub

This guide is also available as PDF or ePub, so if you need a static copy (not always fully up to date) download: [alinex-bashlib.pdf](alinex-bashlib.pdf) or [alinex-bashlib.epub](alinex-bashlib.epub).
