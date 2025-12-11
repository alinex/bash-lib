# spinner_start

## Function to start the spinner in the background

To stop it later call [`spinner_stop`](spinner_stop.md).

Some formats have multiple character width:

- `simple`:   - \ | /
- `arrows`:   → ↑ ← ↓
- `vertical`: ▏ ▎ ▍ ▌ ▋ ▊ ▉ █ ▉ ▊ ▋ ▌ ▍ ▎ ▏
- `bar`:      (as `vertical` but two characters wide)
- `fade`:     ░ ▒ ▓ █ ▓ ▒ ░
- `braille`:   ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏ (default)
- `roll`:     ⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓
- `moon`:     🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘
- `clock`:    🕐 🕑 🕒 🕓 🕔 🕕 🕖 🕗 🕘 🕙 🕚 🕛
- `weather`:  🌤 🌥 🌦 🌧 🌨 🌩 🌪

### Usage

```bash
spinner_start <format> [<time>]
# <format> see above
# <time> 0.1 or more seconds (default 0.2)
```

### TTY (direct)

```bash
<symbol> with back-space so that cursor is always before it
```

### Return (exit code)

- 0 without doing anything if no `tput` and terminal available
- 
