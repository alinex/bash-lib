# hash

## After declaring a variable as associative array: `declare -A <array-name>`



### Usage

```bash
hash <array-name> {set|get|unset|has} <key> [<value>]
```

### Examples

- hash cache set "myname" "any value"
- hash cache get "myname"
- hash cache has "myname"
- hash cache unset "myname"
