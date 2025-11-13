# Unit Tests

See [Contribution](../CONTRIBUTING.md) for a detailed explanation.

This folder contains only setup and results.
The tests are beside the code and the runner is in the main directory `./test` or use `bats` directly.

## Setup Files

```bash
bats-library-loader # include within the bats test files to load the needed library
docker.matrix       # list of distributions to run docker tests on it (lines can be commented to exclude)
setup/              # setup files for the docker and ci tests
results/            # output of last bats unit tests
# additional modules for bats
bats-core/
bats-assert/
bats-support/
```
