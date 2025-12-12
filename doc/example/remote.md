# Remote Execution

The BashLib allows you to easily run every common remotely as easy as locally.

Therefore we have multiple methods:

- @remote
- @remote_bashlib
- @upload
- @download

## Simple Remote Commands

You can easily set the server and login in your code and then run multiple remote commands only by adding `remote` before them.

```bash
$ server=my-server.provider.de
$ login=admin # if nothing given operator will be used

$ remote hostname -f
my-server.provider.de
```

Additionally you can gibe the server and login on each call:

```bash
$ remote --host=my-server.provider.de --login=admin hostname -f
my-server.provider.de
```

Options for the remote call has to come always first here.

## Running Complex Scripts

Therefore you can use two different approaches. First you can pipe the script to the remote command:

```bash
$ server=my-server.provider.de
$ echo "hostname -f" | remote
my-server.provider.de
```

Or you can store the script in a file and run this file on the remote host:

```bash
$ server=my-server.provider.de
$ remote --file ./hostname.sh
my-server.provider.de
```

## Running BashLib Remotely

```bash
# run bashlib remotely with <module> <command> <arguments>
$ remote_bashlib software install jq
```

## Upload/Download

Thats very simple and follows the same mechanism as the @remote command.

```bash
$ server=my-server.provider.de

# Upload
$ upload ./myfile.txt ~/test
# Download
$ download ~/test/myfile.txt .
```
