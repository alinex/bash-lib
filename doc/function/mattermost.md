# mattermost

## Send a message to Mattermost

Stdout:   `<postid list>`
Returns:  0 without action if no `$MATTERMOST_API` + `$MATTERMOST_TOKEN`


### Usage

```bash
mattermost <channel-name> <text> [<attachments>]
```

### Globals

- `$MATTERMOST_API` + `$MATTERMOST_TOKEN` to access API
