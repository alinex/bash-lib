# Using Step Control

Step control allows to run a big process which is parted into steps in multiple calls. If it breaks or will be terminated you may restart the process and it will know what already was done, load the results from before and go on with it.

On a rerun it will restart on the step which it stopped again but skip previous, completely finished ones.

The process looks like:

```bash
# define which variables should be hold over steps and be reset on a rerun after that
STEPS_VARIABLES="num"
# initialize step control, without this line everything will work but without resume
steps init

# define a step as a subroutine
task_1() {
    sleep 10
    num=1
}
# run the above step
sync task_1
# always run this line
echo "num=$num"

# and the same again as a second task
task_2() {
    sleep 10
    num=2
}
sync task_2
echo "num=$num"

# and the same again as a third task
task_3() {
    sleep 10
    num=3
}
sync task_3
echo "num=$num"

# and if you reach this everything is done and the step control will be finished so the next run is a new run
steps end
```
