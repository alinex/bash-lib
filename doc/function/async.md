# async

## Run the given command asynchronous ang go on in the calling routine (short form of async_name)

This will use the command itself as name. If you run the same command multiple times use
async_name directly.


### Usage

```bash
async <command> [<params>...]
```

### Example

```bash
async task1
async task2
async_wait task1
async task3
wait # for all to end
```
