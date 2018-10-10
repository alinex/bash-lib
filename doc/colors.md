# Color Variables

Setup color variables to be used in bash scripts for formatting.

## Usage

```bash
source ../helper-lib/colors  # load variables
echo -e "${RED}Failed${RESET}"
```

## List of Variables

- `RESET` to end all formatting and fall back to default

Text colors:

- `BLACK`
- `RED`
- `GREEN`
- `YELLOW`
- `BLUE`
- `MAGENTA`
- `CYAN`
- `WHITE`

Background colors:

- `BG_BLACK`
- `BG_RED`
- `BG_GREEN`
- `BG_YELLOW`
- `BG_BLUE`
- `BG_MAGENTA`
- `BG_CYAN`
- `BG_WHITE`

Font styles:

- `BOLD`
- `NORMAL`
- `ITALIC`
- `UNDERLINE`
- `BLINK`
- `INVERT`
