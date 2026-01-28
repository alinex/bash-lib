# user_info

## Get information about user

### Usage

```bash
user_info [<user>]
```

### Output (stdout)

`<tsv with header>`
User UID  GID  Home       SuDo Login                     From    Duration
alex 1000 1000 /home/alex all  2026-01-13T07:01:09+01:00 0.0.0.0 still logged in


### Description


The sudo column will show: no, all, specified.
Find more about the sudo rights using [`sudo_info`](sudo_info.md).

