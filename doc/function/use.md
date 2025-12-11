# use

## Load bashlib module

This can be used to load a special additional module as needed. If you try to load something which is already loaded it will do nothing.

The core modules are always loaded, so you won't need to load them.
Something from the module folder can be loaded manually if you are started with only the base library.
And finally the extra folder has always to be loaded individually.

### Usage

```bash
use [<folder>/]<module>
```

### Globals

- `$BASHLIB_LOADER` to know which loader was used
- 
