# Core

This part of the bash lib contains some general helper methods which are not suitable
to be put in other lib parts.

## path

Get the absolute path to the called script. It's the same as `$source_dir` which is used in the general examples but this stays the same while the variable may be changed in scripts.

```bash
# load the help file shich will output help pages directly beside the script
source "$(path)/$(basename $0).help"
```

It is always the directory path of the first called script which included the libraries.

## usesudo

This will return a short string containing `'sudo'` or an empty string `''` if no `sudo` is needed or possible. This will return the sudo command only if not user `root` and `sudo` is generally allowed for the active user.

This can be stored in a variable `$usesudo` and used to make command calls:

```bash
usesudo=$(usesudo)
$usesudo systemctl start my_service
```

## needsudo

This method will check the `sudo` rights and exit with an alert message if there is a problem. This can be:

-   if the active user is not `root` and `sudo` is not allowed
-   if commands are given aren't allowed to be called using `sudo` for the active user

To check only the general `sudo` need and allowance:

```bash
needsudo
```

And to check some specific commands use:

```bash
needsudo "systemctl start tomcat8"
```

{!docs/assets/abbreviations.txt!}
