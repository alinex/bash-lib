# Error Handler

A collection of different error handler to be used for easy checking and exiting the program.

## Usage

First include this library which will also include the colors library:

```bash
source ../helper-lib/errors  # load error handler
```

All methods may be called as

- `error_...` to only output the error message but go on in code
- `exit_...` to also stop processing here and return with the additional given exit code or 1

```bash
error_message "Invalid setup!"
exit_message "Invalid setup, stopping!", 127
```

## error_message / exit_message

Used to emit error messages and do a possible exit.

Parameters:

- `message` a text to be displayed on `STDERR`
- `code` (optional for exit_message) the return code for exit or 0 to not exit (default is 1)
