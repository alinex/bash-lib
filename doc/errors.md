# Error Handler

A collection of different error handler to be used for easy checking and exiting the program.

## Usage

```bash
source ../helper-lib/errors  # load error handler
error_message "Invalid setup, stopping!", -1
```

## error_message

Used to emit error messages and do a possible exit.

Parameters:

- `message` a text to be displayed on `STDERR`
- `code` (optional) the return code for exit or 0 to not exit (default is 1)
