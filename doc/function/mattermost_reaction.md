# mattermost_reaction

## Add reaction to existing post

This can only be called if a [`mattermost`](mattermost.md) call was used previously.
Returns:  0 without action if no `$MATTERMOST_API` + `$MATTERMOST_TOKEN`


### Usage

```bash
mattermost_rteaction <emoji>
```

### Options

```bash
-l, --links     # also post this to the links
```

### Globals

- `$MATTERMOST_API` + `$MATTERMOST_TOKEN` to access API
