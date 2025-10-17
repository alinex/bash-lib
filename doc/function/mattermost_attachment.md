# mattermost_attachment

## Create an attachment json to be used in post

Stdout:   `<json>` for this attachment
Find free linkable icons under https://icons8.de/icons/all


### Usage

```bash
mattermost_attachment
mattermost_post `$channelid` "" "$(mattermost_attachment --color ...)"
```

### Options

```bash
--color <hexcode>   # rgb color or names: critical, error, warning, ok, info, default
--text <md>         # text content
--author <name>     # author name
--avatar <url>      # author icon
--home <url>        # author link
--title <string>    # title
--link <url>        # title link
--image <url>       # bottom image
--thumb <url>       # right image
--fields <json>     # array title=<words>, value=<text>, short=false
--footer <string>   # footer
--logo <url>        # footer image
```
