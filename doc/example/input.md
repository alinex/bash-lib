# User Interaction

The library contains some powerful input methods which you can use for user interaction.

We only show the part of the script which will do the tasks, see [Base Script](./base_script.md) for the start of the script.

## Pause

The [`pause`](../function/pause.md) function is very simple, it will wait to go on in the program code. Possibilities are:

- give a custom message
- go on if any key is pushed
- go on if a timer has finished
- abort the timer by kex press to directly move on

So the simplest call will be:

```bash
$ source $BASHLIB_HOME/full
$ pause
Taste drücken um fortzufahren... 
```


