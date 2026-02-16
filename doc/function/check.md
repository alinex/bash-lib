# check

## Validate value against rule

### Usage

```bash
check string <value> <operator> [<compare>]
check integer <value> <operator> [<compare>]
check float <value> <operator> [<compare>]
```

### Return (exit code)

- 0 if ok

### Examples

`check "`$a`" == "`$b`"`


### Description


If you have more than one condition, call it multiple times.

Text Operators:

- `=`, `==`   - equal string presentation
- `!=`        - not equal string presentation
- `=*`        - match against pattern
- `!*`        - no match against pattern
- `=~`        - match against regular expression
- `!~`        - no match against regular expression
- `<`         - alphabetical before
- '>`'         - alphabetical behind
- `empty`     - unset or empty string
- `set`       - has a value

Integer Operators:

- `=`
- `<`
- `>`
- `<=`
- `>=`
- `positiv`
- `negativ`
- `zero`
- `odd`
- `even`
- `multiple-of` or `divisible-by`
- `factor-of`
- `prime`
- `no-prime`

Float Operators:

- `=`
- `<`
- `>`
- `<=`
- `>=`
- `positiv`
- `negativ`

Because some of the operators use special characters like `< > ! *` you have to put this in quotes or prefix them with backslashes.

