# jira

## Jira API calls

### Usage

```bash
jira get <issueId>|<key>                      # get an jira issue
jira search <jql>                             # search jira issue id
jira update <ticket-id> <json>                # update jira issue
jira create <json>                            # create new jira issue
jira delete <issueId>|<key>                   # delete jira issue
jira project <key>                            # get project information
jira fields <projectId>|<key> <issueTypeId>   # get fields by project and issue type
# work with the issue json:
jira json <json> set <field> [adf|json] <value>   # set field with the possibility to format (from markdown) adf fields
jira json <json> get <field> [md]                 # get field value with possible format adf field as markdown
jira json <json> remove <field>
# convert atlassian document format:
jira md_to_adf <json>
jira adf_to_md <md>
```

### Globals

- - `$JIRA_HOST`
- - `$ATLASSIAN_USER`
- - `$ATLASSIAN_TOKEN`

### Output (stdout)

- get: `<json>`
- search: `<issueId>` list, each in a separate line
- create: `<issueId>` which was just created

### Return (exit code)

- - die on 400, 404 Error
- - retry on other not 2xx Code
- 

### Description


To connect the `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` is needed.
Jira API V3 is used there: https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro which brings some elements in the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/).

The following commands are supported:

- `get` will return all fields of an issue as json
- `search` will find matching issues
- `create` to generate a new issue
- `delete` to remove an issue
- `json` manipulate jira issue json

The Jira JSON consists of the `fields` array and some additional meta like `id`, `key`. To simplify work with it the json helper allows to manipulate it.

