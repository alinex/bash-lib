# trivy_report

## Optimize the result of a trivy scan.

### Usage

```bash
trivy_report [options] <work>
```

### Options

```bash
-p, --progress             # show progress
```

### Globals

- - `$TRIVY_JIRA_BOARD`
- - `$TRIVY_JIRA_ISSUE_TYPE`
- - `$TRIVY_JIRA_FIELD_SOURCES`
- - `$TRIVY_JIRA_FIELD_RATING`
- - `$TRIVY_JIRA_FIELD_VERSION`
- - `$TRIVY_JIRA_FIELD_LINKS`
- - `$TRIVY_JIRA_FIELD_APPROVAL`
- - `$TRIVY_JIRA_APPROVAL_TEMP`
- - `$TRIVY_JIRA_APPROVAL_IRRELEVANT`

### Files

- - `<work>` directory will be used

### Error (stderr)

Progress output if `--progress` is set with optimizations on reports

### Return (exit code)

- 1 if there are at least one CRITICAL or HIGH vulnerabilities
- 

### Description


It will make the analysis reports in the given directory:


```
trivy.json - should already be there
<severity>/
  <type>/
      <cve-id>/
          data.json
```

After use you should remove this temporary folder to reclaim space.

The pure trivy data will be optimized by:

- downgrade security level if published in the last days
- add exploit information
- downgrade if node development package
- connect with jira ticket management

The jira ticket management needs some setup to work, all `JIRA_TRIVY_*` settings have to be set defined and therefore you need a board there you manage this tickets.
Please make sure the custom fields are created for each of the setting. The approval needs also two defined values for temporarily allowed or irrelevant = always allowed.

An Example is Board SEC with an `IssueType=Code`  which has the fields:

- Sources as textarea field to store information of there this was found
. Rating as textarea field containing the values from CVSS
- Version as textarea field containing the installed and fixed version
- Links as textarea field for all the references from trivy
- Approval as enumeration with: Null, Blocked, Irrelevant, Allowed for 30 days

