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
--no-secrets               # run only vulnerability scanner
-c, --clean                # immediately clean trivy database after scan
```

### Globals

- - `$TRIVY_DEFAULT_TIMEOUT`
- - `$TRIVY_CACHE_SERVER`
- - `$TRIVY_ROOT_EXCLUDE`

### Files

- - /tmp/`<script>`_`<pid>`_trivy/    is created containing all reports
- - potentially all files are scanned

### Output (stdout)

`<report-path>` or nothing if no vulnerabilities found

### Tools used

- trivy - Scanner for vulnerabilities in container images, file systems
- 

### Description


If not installed it will install trivy and then use it.
It will run the security analysis and output the directory in which you find all data:


```
trivy.json - the original output of trivy containing all vulnerabilities
```

This can further be analyzed and optimized using [`trivy_report`](trivy_report.md).

After use you should remove this temporary folder to reclaim space.

Warning: This will overwrite the original trivy command, so if you want to use trivy directly while bashlib is loaded, use `command trivy ....`

