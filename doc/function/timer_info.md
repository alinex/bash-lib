# timer_info

## Systemd Timer

### Usage

```bash
timer_info
```

### Output (stdout)

`<tsv with header>`

```text
Quelle                  Status  Konfiguration                                  Schedule                                 Last                        Next                        Service
anacron.timer           enabled /usr/lib/systemd/system/anacron.timer           *-*-* 07..23:30                         Mon 2026-02-16 19:32:00 CET Mon 2026-02-16 20:30:21 CET anacron.service
apt-daily-upgrade.timer enabled /usr/lib/systemd/system/apt-daily-upgrade.timer *-*-* 6:00                              Mon 2026-02-16 07:10:12 CET Tue 2026-02-17 06:41:22 CET apt-daily-upgrade.service
apt-daily.timer         enabled /usr/lib/systemd/system/apt-daily.timer         *-*-* 6,18:00                           Mon 2026-02-16 14:19:25 CET Tue 2026-02-17 00:36:52 CET apt-daily.service
ua-timer.timer          enabled /usr/lib/systemd/system/ua-timer.timer          1min after startup; 6h after last start                                                         ua-timer.service
```


### Description


