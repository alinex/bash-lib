# spinner_start

## Function to start the spinner in the background

### Usage

```bash
spinner_start <format> [<time>]
# <format> see above
# <time> 0.1 or more seconds (default 0.2)
```

### TTY (direct)

`<symbol>` with back-space so that cursor is always before it


### Description


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

