# queue

## Add command to process queue

This will use the command itself as name. If you run the same command multiple times use
queue_name directly.


### Usage

```bash
queue <command> [<params>...]
```

### Examples

- queue task1
- queue task2
- queue task3
- async_wait task2
- queue task4
- wait # for all to end
