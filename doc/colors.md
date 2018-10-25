# Color Output

Setup color variables to be used in bash scripts for formatting.

![example](colors.png)

## Usage

First you have to load the library:

```bash
source ../bash-lib/colors.bash  # load color methods
```

Now you can use colorized output in different ways:

```bash
red "Direct ouput without newline"
echo "$(red 'output with newline')"
x=$(red "load colorized into variable")
x="manually switch $(red)on$(reset) and off"
```

Above you see the different possibilities to use.

1. **Format text** if a text is given and end the style after it
2. **Only start style** if called without arguments

## Foreground color

- `black`
- `red`
- `green`
- `yellow`
- `blue`
- `magenta`
- `cyan`
- `white`

# Background color

- `bg_black`
- `bg_red`
- `bg_green`
- `bg_yellow`
- `bg_blue`
- `bg_magenta`
- `bg_cyan`
- `bg_white`

## Styles

- `bold`
- `underline`
- `inverse`
- `dim`

## Reset

- `reset`
