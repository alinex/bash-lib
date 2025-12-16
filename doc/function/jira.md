# jira

## https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-group-issues


Jira API calls
To connect the `$ATLASSIAN_USER` and `$ATLASSIAN_TOKEN` is needed.
Jira API V3 is used there: https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro which brings some elements in the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/).

The following commands are supported:

- `get` will return all fields of an issue as json
- `search` will find matching issues


### Usage

```bash
jira <command> <options>...
jira get <issueId>|<key>
jira search <jql>
jira update <ticket-id> <json>
jira create <json>
```

### Output (stdout)

- get: `<json>`
- search: `<issueId>` list, each in a separate line

### Return (exit code)

- die on 400, 404 Error
- retry on other not 2xx Code
- 
