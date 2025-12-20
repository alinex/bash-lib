# trivy

## Run a trivy security analysis.

If not installed it will install trivy and then use it.
It will run the security analysis and output the directory in which you find all data:


```
trivy.json - the original output of trivy containing all vulnerabilities
<severity>/
  <type>/
      <cve-id>/
          report.json
```

After use you should remove this temporary folder to reclaim space.

Warning: This will overwrite the original trivy command, so if you want to use trivy directly while bashlib is loaded, use `command trivy ....`

### Usage

```bash
trivy [<options>] root
trivy [<options>] files <path>
trivy [<options>] docker <file>
trivy [<options>] docker <image>
```

### Options

```bash
t, timeout <duration>   set the timeout for the job in <int>m or <int>h
o, only-os              let `root` command only scan OS without filesystem traversal
```

### Output (stdout)

`<report-path>` or nothing if no vulnerabilities found

### Return (exit code)

- 1 if there are at least one CRITICAL or HIGH vulnerabilities
- 
