# Mattermost

The following examples shows how to interact with Mattermost.

A simple information will look like:

```bash
# Make a first post to the channel associated with the server name
mattermost $server "**KeyCloak wird aktualisiert und fällt gleich ganz kurz aus...**"
# Directly extend the posting with a sub post
mattermost_repost "$(alerts -i $server md)"
# do something
....
# Mark post as done
mattermost_repost "Fertig."
mattermost_reaction check
```

The concrete channels to which to post will be automatically calculated based on the defined pattern. Therefor the `MATTERMOST_CHANNEL_PATTERN` will be scanned top to bottom for all available teams. Each entry contains:

- Team Name
- Regex Pattern
- Channel Name (- => make no Post in this team, same as if no pattern match)

And the first match for each team will define the channel. Also the `MATTERMOST_LINK_PATTERN` will be scanned to know which additional channels have to be informed by link to the new post.

```bash
# Array: Channel per pattern (team regex channel) used in @mattermost, @mattermost_repost ("-"" = no selection for team)
MATTERMOST_CHANNEL_PATTERN=(
    divibib Entwicklung "Entwicklung"
    divibib Spielwiese "Spielwiese"
    ...
)
# Array: Link channel per pattern (team regex channel) used in @mattermost, @mattermost_repost ("-"" = no selection for team)
MATTERMOST_LINK_PATTERN=(
    divibib Entwicklung "Spielwiese"
    ...
)
```
