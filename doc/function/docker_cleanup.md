# docker_cleanup

## Cleanup docker installation

### Usage

```bash
docker_cleanup
```

### Description


This will remove:

- all stopped **containers**
- all unused **networks**
- all **images** which are unused
- cleanup the **build cache**
- all **volumes** that are not referenced by any container (running or stopped)


