# cron_info

## List cron jobs.

### Usage

```bash
cron_info
```

### Output (stdout)

`<tsv with header>`

```text
Type  Source                         User  Minute   Hour  Day  Month  Weekday  Command
cron  /var/spool/cron/crontabs/alex  alex  0        9     *    *      *        tar -czf /mnt/drive-alinex/backup/$(date +%d)_sec.tgz /mnt/drive-alinex/sec
cron  /etc/crontab                   root  17       *     *    *      *        cd / && run-parts --report /etc/cron.hourly
cron  /etc/crontab                   root  25       6     *    *      *        test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; }
cron  /etc/crontab                   root  47       6     *    *      7        test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.weekly; }
cron  /etc/crontab                   root  52       6     1    *      *        test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.monthly; }
cron  /etc/cron.d/anacron            root  30       7-23  *    *      *        [ -x /etc/init.d/anacron ] && if [ ! -d /run/systemd/system ]; then /usr/sbin/invoke-rc.d anacron start >/dev/null; fi
cron  /etc/cron.daily                root  25       6     *    *      *        /etc/cron.daily/sysstat
cron  /etc/cron.weekly               root  47       6     *    *      7        /etc/cron.weekly/man-db
cron  /etc/cron.monthly              root  52       6     1    *      *        /etc/cron.monthly/0anacron
```


### Description


