# hash

## After declaring a variable as associative array: `declare -A <array-name>`



### Usage

```bash
hash <array-name> {set|get|unset|has} <key> [<value>]
```

### Examples

- hash cache set "my_name" "any value"
- hash cache get "my_name"
- hash cache has "my_name"
- hash cache unset "my_name"
