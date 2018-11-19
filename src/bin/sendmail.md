# Send Email

This `sendmail` command can be called from command line.

## Usage

    sendmail [options]

Required arguments are:

- `-f ADDRESS` from (sender) email address (default: `SMTP_USERNAME`)
- At least one recipient required via `-t`, `-cc`, or `-bcc`
- Message body required via `-m`, `STDIN`, or `-o message-file=FILE`

### Server

- `-s SERVER[:PORT]` SMTP mail relay (default: `SMTP_SERVER:SMTP_PORT` or `localhost:25`)
- `-xu USERNAME` username for SMTP authentication (default: `SMTP_USERNAME`)
- `-xp PASSWORD` password for SMTP authentication (default: `SMTP_PASSWORD`)
- `-o tls=<auto|yes|no>`
- `-o timeout=SECONDS`
- `-o fqdn=FQDN` if you need to change the server name used in SMTP greeting
- `-b BINDADDR[:PORT]` local host bind address

For GMail user: `-s smtp.gmail.com:587 -xu me@gmail.com -xp PASSWD`

Alternatively this settings can be given as environment variables:

- `SMTP_SERVER`
- `SMTP_PORT`
- `SMTP_USERNAME`
- `SMTP_PASSWORD`

The `SMTP_USERNAME` is also used as from address if no other option given.

They may be set in `.bashrc` or elsewhere.

### Addressing

- `-f ADDRESS` from (sender) email address
- `-t ADDRESS [ADDR ...]` to email address(es)
- `-cc ADDRESS [ADDR ...]` cc email address(es)
- `-bcc ADDRESS [ADDR ...]` bcc email address(es)
- `-o reply-to=ADDRESS`

These options each accept multiple addresses. They may be
specified by separating them by either a white space, comma, or semi-colon
separated list. You may also specify the `-t`, `-cc`, and `-bcc` options multiple
times, each occurrence will append the new recipients to the respective list.
This may look like: `-t "jane.doe@yahoo.com" -t "John Doe <john.doe@gmail.com>"`

### Message

- `-u SUBJECT` message subject
- `-m MESSAGE` message body
- `-o message-content-type=<auto|text|html>`
- `-o message-file=FILE` use the files content as message
- `-a FILE [FILE ...]` file attachment(s)
- `-o message-format=raw`
- `-o message-header=HEADER`
- `-o message-charset=CHARSET`

The message may also be retrieved from `STDIN`, so you can pipe it to this command.

### Output

- `-l LOGFILE` log to the specified file
- `-v` verbosity, use multiple times for greater effect
- `-q` be quiet (i.e. no `STDOUT` output)
