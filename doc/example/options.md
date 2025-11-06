# Parameters and Options

A lot of functions of the BashLib use options and your scripts should also, at least the `--help` option ;-)

- **Parameters** are everything a command (script or function) will get after its name.
- **Options** are the additional flags and key-value pairs of the parameters.
- **Arguments** are the additional information from the arguments which are no options.

## Option Possibilities

BashLib accepts options and arguments in a consistent, POSIX-style way, supporting both short and long options which is described with some examples below. BashLib is based on GNU getopt.

Which options you have is shown in the [BashLib API](../README.md) or your scripts `--help` output.

### Short Options

Short options are only one Letter and may not be available for each option, they can be flags or with an additional argument:

```bash
my_function -a -f input.txt arg1 arg2
# -a                short option flag
# -f input.txt      short option with an argument
# arg1 arg2         command arguments
```

### Long Options

Every option (in BashLib) has always a long form which is more readable and can be used identically to the short form:

```bash
my_function --alpha --file=input.txt arg1 arg2
# --alpha           long option flag
# --file input.txt  long option with an argument
# arg1 arg2         command arguments
```

### Mixed Option Types (Permutation)

This is an optional feature which is by default enabled. But if the `<spec>` starts with `+` the option processing stops as soon as the first non-option argument is found all behind are arguments.

If perumtation is allowed (default) you can also mix everything together in any order for short, long options and arguments:

```bash
my_function -a cmd arg1 --file input.txt
# -a                short option flag
# --file input.txt  long option with an argument
# cmd arg1          command arguments
```

If it is not allowed, `<spec>` starts with `+`:

```bash
my_function -a cmd arg1 --file input.txt
# -a                short option flag
# cmd arg1          command arguments (from this scope)
# --file input.txt  is seen as argument here, but maybe an option under `cmd`
```

### Argument Separation

If your arguments may start with an dash `-` they will be treated as option. To prevent this you can separate them by defining an end of option parsing using `--` after this no more options will be parsed and all following will be arguments:

```bash
my_function --alpha --file=input.txt -- -arg1 arg2
# --alpha           long option flag
# --file input.txt  long option with an argument
# -arg1 arg2         command arguments
```

Sometimes it is also a good idea to add this separator for easier reading.

### Alternativer Style

Further there are additional alternative Styles supported.

- `-fdata` - short option with argument `data`
- `--file=data` - long option with argument `data`

> The first is not so easy to read but the second is  perfect to better show that the argument belongs to the option. So for readiness use it.

### Combined Short Options

And at last multiple short options may be combined together:

- `-vcd` is the same as `-v -c- d`
- `-vfdata` is the same as `-v -f data`

But you can only have one option with argument at last, not multiple in one combination!
