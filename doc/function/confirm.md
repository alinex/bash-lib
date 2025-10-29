# confirm

## Ask a yes/no question.

The default can be yes or no and if a default is set `<return>` will use it. Additional to a default a timeout can be set meaning to use default if timeout is reached. If an invalid character is typed, the timeout will restart.


### Usage

```bash
confirm <question>
```

### Options

```bash
-t, --true                  # default: yes
-f, --false                 # default: no
-t, --timeout <duration>    # time after which the default will be used
```

### TTY (direct)

```bash
<question> <key>
```
