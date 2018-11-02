# Color Output

Setup color variables to be used in bash scripts for formatting. It will output ANSI color codes.

![example](colors.png)

The terminal will automatically interpret this but to also see them in other programs use:

- `alias less='less -R'` enables ANSI color support

## Usage

First you have to load the library:

```bash
source ../bash-lib/colors.bash  # load color methods
```

Now you can use colorized output in different ways:

```bash
red "Direct ouput without newline"
echo "$(red 'output with newline')"
echo "$(red multiple parameters are joined by spaces)"
x=$(red "load colorized into variable")
x="manually switch $(red)on$(reset) and off"
echo "This text is colored using pipe" | cyan
```

Above you see the different possibilities to use.

1. **Format text** if a text is given and end the style after it
2. **Only start style** if called without arguments
3. **Text given as pipe** instead of parameters

And if you want to remove the coloring later again:

```bash
ctext=$(bg_red "This text with red background")
echo "original: $ctext"
echo "uncolor using parameters: $(uncolor $ctext)"
echo "uncolor using pipe: $ctext" | uncolor
```

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
