# jira

## https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-group-issues


Jira API calls
To connect the `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` is needed.
Jira API V3 is used there: https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro which brings some elements in the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/).

The following commands are supported:

- `get` will return all fields of an issue as json
- `search` will find matching issues
- `create` to generate a new issue
- `delete` to remove an issue
- `json` manipulate jira issue json

The Jira JSON consists of the `fields` array and some additional meta like `id`, `key`. To simplify work with it the json helper allows to manipulate it.


### Usage

```bash
jira <command> <options>...
jira get <issueId>|<key>
jira search <jql>
jira update <ticket-id> <json>
jira create <json>
jira delete <issueId>|<key>
jira json <json> set <field> <value>
jira json <json> get <field>
jira json <json> remove <field>
```

### Output (stdout)

- get: `<json>`
- search: `<issueId>` list, each in a separate line
- create: `<issueId>` which was just created

### Return (exit code)

- die on 400, 404 Error
- retry on other not 2xx Code
- 
