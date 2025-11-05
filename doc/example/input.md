# User Interaction

The library contains some powerful input methods which you can use for user interaction.

> We only show the part of the script which will do the tasks, see [Base Script](./base_script.md) for the start of the script.
> Also I work on a german machine so I get the output in german by default. For the examples here I switch to english using `LANG=en_EN.UTF-8` which is not shown in the examples.

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
Press any key to continue...
```

Then you can customize the title:

```bash
$ source $BASHLIB_HOME/full
$ pause "If you are ready, hit any key..."
If you are ready, hit any key... 
```

And then also set a countdown:

![`pause --timeout=10s`](images/pause-timeout.gif)

And at last you can make the countdown abortable:

![`pause --timeout=2m --abort`](images/pause-abort.gif)

## Confirm

With [`confirm`](../function/confirm.md) you can ask a yes/no question to the user, mostly to confirm to do something or not to do something. Only one key press is needed to work: `yYjJ := true` and `nN := false`.

Possibilities here are:

- give the question
- has yes or no as default
- timeout with default

A simple question may be:

![`confirm`](images/confirm.gif)

> As you see invalid input will trigger a warning.

Next you can make your own question:

```bash
$ source $BASHLIB_HOME/full
$ confirm "Should the file trash.list be deleted"
Should the file trash.list be deleted? No
```

If a default is set this can be used by pressing `<return>`-key.

```bash
$ source $BASHLIB_HOME/full
$ confirm "Should the file trash.list be deleted" --false
Should the file trash.list be deleted [No]? No
```

And if a timeout and default is given together it will use the default after the timeout ends:

```bash
$ source $BASHLIB_HOME/full
$ confirm --timeout=30s --false
Should this be done [No]? No
```

## Ask

The [`ask`](../function/ask.md) function is a very powerful and supports multiple input patterns:

- `string` - (default) allow anything
- `integer` or `number` - only allow [0-9]
- `float` - allow number [0-9]+.[0-9]+ (alternative , is allowed as decimal separator)
- `password` - will show only `*` characters to hide input

To ask for any input use (the last line is the return value):

```bash
$ source $BASHLIB_HOME/full
$ ask
Enter short text: hello
hello
```

> You have to finish your input line with a `<return>`-key. Multiline input is not supported.

Next you can have your own question if you need this you have to set the format, we use the default `string` here:

```bash
$ source $BASHLIB_HOME/full
$ ask string "What is your name"
What is your name: Alex
Alex
```

Also you can give a default value which will be used if an empty string is provided:

```bash
$ source $BASHLIB_HOME/full
$ ask --default=Hello
Enter short text [Hello]: 
Hello
```

The last universal flag is `--empty` which allows to enter an empty string with return (not possible if default is set):

```bash
$ source $BASHLIB_HOME/full
$ ask --empty
Enter short text: 

```

And if a timeout and default/empty is given together it will use the default after the timeout ends:

```bash
$ source $BASHLIB_HOME/full
$ confirm --timeout=30s --false
Should this be done [No]? No
```

Now you can also ask for numeric formats which will be checked while typing. So you can't enter an invalid string here:

![`ask-number`](images/ask-number.gif)

> As shown any invalid character will not be accepted and a warning is shown.

The possible characters vary if you set `--negative` a `-` in front is also possible but nowhere else.

The same goes for `float` where a single `.` within the value is also possible.

A special thing is `password` which will show you how strong it is and only display stars while the real value is returned:

![`ask-password`](images/ask-password.gif)

> The last character was really a `*` ;-)

And at last it provides also a `time` format where you can type `hh:mm` and nothing else.

## Choose

The [`choose`](../function/choose.md) function will give you a selection list from which to decide what you want (single choice).

## Tasks

This is a special use case for choose which is explained in it's own [tasks example](./tasks.md).

> As before the last line of output will show the return value.

```bash
$ source $BASHLIB_HOME/full
$ choose one two three
  1) one
  2) two
  3) three
Select one of the above options: 2
two
```

Here you can add a title:

```bash
$ source $BASHLIB_HOME/full
$ choose --title=numbers one two three
Numbers
  1) one
  2) two
  3) three
Select one of the above options: 2
two
```

Select an default:

```bash
$ source $BASHLIB_HOME/full
$ choose --default=1 one two three
  1) one
  2) two
  3) three
Select one of the above options [1]: 
one
```

Select the default by name:

```bash
$ source $BASHLIB_HOME/full
$ choose --default=three one two three
  1) one
  2) two
  3) three
Select one of the above options [3]: 
three
```

And you can set a timeout:

```bash
$ source $BASHLIB_HOME/full
$ choose --default=three --timeout=10s one two three
  1) one
  2) two
  3) three
Select one of the above options [3]: 
three
```

The options to select can also be `key|name` pairs:

```bash
$ source $BASHLIB_HOME/full
$ choose 'one|thirst option' 'two|second option' 'three|third option'
  1) thirst option
  2) second option
  3) third option
Select one of the above options: 2
two
```

And you can give the options using `STDIN` as different lines:

```bash
$ source $BASHLIB_HOME/full
$ echo "
# list all options
one   | thirst option
two   | second option
three | third option
" | choose
  1) thirst option
  2) second option
  3) third option
Select one of the above options: 2
two
```

> As you see this is a clean and visual way, empty lines, comments and spaces around key and name are removed.
