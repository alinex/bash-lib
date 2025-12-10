# mattermost

## Send a message to Mattermost



### Usage

```bash
mattermost <channel-name> <text> [<attachments>]
```

### Globals

- `$MATTERMOST_API` + `$MATTERMOST_TOKEN` to access API

### Output (stdout)

- `<postid list>`

### Return (exit code)

- 0 without action if no `$MATTERMOST_API` + `$MATTERMOST_TOKEN`
