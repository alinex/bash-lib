# trivy

## Run a trivy security analysis.

### Usage

```bash
trivy [<options>] root
trivy [<options>] files <path>
trivy [<options>] docker <file>
trivy [<options>] docker <image>
trivy clean
```

### Options

```bash
-t, --timeout <duration>   # set the timeout for the job in <int>m or <int>h
-o, --only-os              # let `root` command only scan OS without filesystem traversal
-e, --exclude <dirs>       # additional excludes for `root` command
-p, --progress             # show progress
-c, --clean                # immediately clean trivy database after scan
--no-secrets               # run only vulnerability scanner
```

### Globals

- - `$TRIVY_DEFAULT_TIMEOUT`
- - `$TRIVY_CACHE_SERVER`
- - `$TRIVY_ROOT_EXCLUDE`
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

- - /tmp/`<script>`_`<pid>`_trivy/    is created containing all reports
- - potentially all files are scanned

### Output (stdout)

`<report-path>` or nothing if no vulnerabilities found

### Error (stderr)

Progress output if `--progress` is set with optimizations on reports

### Return (exit code)

- 1 if there are at least one CRITICAL or HIGH vulnerabilities

### Tools used

- trivy - Scanner for vulnerabilities in container images, file systems
- 

### Description


If not installed it will install trivy and then use it.
It will run the security analysis and output the directory in which you find all data:


```
trivy.json - the original output of trivy containing all vulnerabilities
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

Warning: This will overwrite the original trivy command, so if you want to use trivy directly while bashlib is loaded, use `command trivy ....`

