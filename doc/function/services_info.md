# services_info

## Show services on VM

### Usage

```bash
services_info <filter>
```

### Output (stdout)

`<tsv with header>`


```text
Unit                    Active   Sub     Enabled Description                    Config                                              Start                           Tasks     Memory    CPU
accounts-daemon.service active   running enabled Accounts Service               /usr/lib/systemd/system/accounts-daemon.service                                     4         6037504   782021000
alsa-restore.service    active   exited  static  Save/Restore Sound Card State  /usr/lib/systemd/system/alsa-restore.service        Wed 2026-02-04 07:03:11 CET     [not set] [not set] 23323000
alsa-state.service      inactive dead    static  Manage Sound Card State        /usr/lib/systemd/system/alsa-state.service          Wed 2026-02-04 07:03:11 CET     [not set] [not set] [not set]
```


### Description


This lists all installed services. You may use filters to see specific ones, therefore some predefined filters are available but you may use [`tsv filter`](tsv.md) to use your own.

The following filters are build into this routine:

- `special` - remove all services which belong to the default management set
- `active` - show only active services

