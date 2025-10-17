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

> ['mattermost'](../function/mattermost.md) will make the post
> ['mattermost_repost'](../function/mattermost_repost.md) will add into this thread
> ['mattermost_reaction'](../function/mattermost_reaction.md) will add a emoji reaction

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

If you want to add attachments to initial mattermost post or repost add another argument with the json:

```bash
json=<<EOT
[
  {
    "color": "#0000FF",
    "title": "Info: Partner Problem",
    "linktitle_link": "http://grafana.service.cloud.dvb/alerting/grafana/fevrx0146bn5se/view",
    "text": "**Plusserver hat derzeit maintenance Probleme**
Siehe hierzu mehr unter https://status.plusserver.com//api/v2/summary.json",
    "footer": "Grafana Alerts",
    "fields": [
      {
        "title": "Netz",
        "value": "PROD",
        "short": true
      },
      {
        "title": "Instanz",
        "value": "status.plusserver.com",
        "short": true
      }
    ]
  }
]
EOT
mattermost $server "Alert on Server" "$json"
```

The attachment can also be made using a helper ['mattermost_attachment'](../function/mattermost_attachment.md) so you don't have to write the text yourself:

```bash
mattermost $server "Alert on Server" \
    "$(mattermost_attachment --color "#FF8000" --title "Grafana Alert" --text "This is the attachment text.")"
```
