# Small Bash Reference

All of the following is based on Bash > V 4.2!

> This covers only some parts, which may help a lot in deciding what syntax quirk to use.

## Bash Operators

- `[ ... ]` is POSIX-compatible but limited and requires careful quoting.
- `[[ ... ]]` is Bash-specific with enhanced functionality and safer syntax.
- `(( ... ))` is for arithmetic tests returning boolean status.
- `$(( ... ))` for arithmetic evaluation returning computed values.

## Variable expansion

Basic Expansion

- `${var}` — Simply expands to the value of var.

Default Values

- `${var:-default}` — Use default if var is unset or null.
- `${var-default}` — Use default if var is unset (null allowed).
- `${var:=default}` — Assign default to var if unset or null, then expand.
- `${var=default}` — Assign default if var is unset.

Alternate Values

- `${var:+alt}` — Use alt if var is set and not null; else nothing.
- `${var+alt}` — Use alt if var is set (even if null).

String Length

- `${#var}` — Returns length of the value of var.

Substring Extraction

- `${var:offset}` — Extract substring from offset to end.
- `${var:offset:length}` — Extract substring of length from offset.

Pattern Removal

- `${var#pattern}` — Remove shortest match of pattern from start.
- `${var##pattern}` — Remove longest match of pattern from start.
- `${var%pattern}` — Remove shortest match of pattern from end.
- `${var%%pattern}` — Remove longest match of pattern from end.

String Replacement

- `${var/pattern/replacement}` — Replace first match of pattern.
- `${var//pattern/replacement}` — Replace all matches.
- `${var/#pattern/replacement}` — Replace pattern if at start.
- `${var/%pattern/replacement}` — Replace pattern if at end.

Indirect Expansion

- `${!var}` — Expands value of the variable named by var.
- `${!prefix*}` — Expands names of variables beginning with prefix.

Case Change

- `${variable^}` — Converts the first character of the variable's value to uppercase.
- `${variable^^}` — Converts all characters in the variable's value to uppercase.
- `${variable,}` — Converts the first character of the variable's value to lowercase.
- `${variable,,}` — Converts all characters in the variable's value to lowercase.
