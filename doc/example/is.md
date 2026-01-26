# Variable Checking

## Use in Scripts

As shown in the [base script](./base_script.md) you should always check your additional parameters. This is done using [is](../function/is.md):

```bash
local server
is set --name=host --die --message="Usage: $USAGE" --output=server -- "$1"
is integer --name=arguments --max=1 --die --message="Usage: $USAGE" -- $#
echo "Working on $server..."
```

The first line checks that the first parameter '$1' is set and stores it into variable '$server'.
The second line checks that no more than one parameters are given. We don't need to check for lesser parameters because of the first line the minimum is already one.
