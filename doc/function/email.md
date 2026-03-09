# email

## Send an email.

### Usage

```bash
echo <body> | email [options] <subject>
```

### Options

```bash
--to <address>              # send to (multiple)
--cc <address>              # send copy to (multiple)
--bcc <address>             # send blind copy to (multiple)
--text                      # stdin should be send as text/plain (default html)
-a, --attachment <file>    # attache the file
```

### Description



