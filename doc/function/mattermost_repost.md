# mattermost_repost

## Add response to mattermost posting

This can only be called if a [`mattermost`](mattermost.md) call was used previously.

### Usage

```bash
mattermost_response <text> [<attachments>]
```

### Globals

- `$MATTERMOST_API` + `$MATTERMOST_TOKEN` to access API

### Return (exit code)

- 0 without action if no `$MATTERMOST_API` + `$MATTERMOST_TOKEN`
- 
