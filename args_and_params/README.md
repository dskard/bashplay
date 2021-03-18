# Passing scripts arguments and function parameters

## Examples

```bash
$ ./params_play.sh -h
usage: params_play.sh [options] positional_1 positional_2 [positional_3 ...]

Play with argument parsing in bash.

OPTIONS:

-s <s-option>                   set the s variable to s-option
-g <g-option>                   set the g variable to g-option
-h                              Print this help message.
-v                              Verbose
```

```bash
$ ./params_play.sh a b c d

s_option is 'more'
g_option is ''
positional_1 is 'a' (same as 'a')
positional_2 is 'b' (same as 'b')
printing out all of the other positional arguments:
positional_3 is c
positional_4 is d
done printing arguments
calling another function with arguments that were passed in
do_stuff param1 = 'a'
do_stuff param2 = 'b'
calling another script with arguments that were passed in
do_more_stuff: n is '2'
./do_more_stuff.sh: begin printing positional arguments
./do_more_stuff.sh: positional_1 is a
./do_more_stuff.sh: positional_2 is b
./do_more_stuff.sh: positional_3 is c
./do_more_stuff.sh: positional_4 is d
./do_more_stuff.sh: done printing positional arguments
```

```bash
$ ./params_play.sh -s "extra" a b c d

s_option is 'extra'
g_option is ''
positional_1 is 'a' (same as 'a')
positional_2 is 'b' (same as 'b')
printing out all of the other positional arguments:
positional_3 is c
positional_4 is d
done printing arguments
calling another function with arguments that were passed in
do_stuff param1 = 'a'
do_stuff param2 = 'b'
calling another script with arguments that were passed in
do_extra_stuff: n is '2'
./do_extra_stuff.sh: begin printing positional arguments
./do_extra_stuff.sh: positional_1 is a
./do_extra_stuff.sh: positional_2 is b
./do_extra_stuff.sh: positional_3 is c
./do_extra_stuff.sh: positional_4 is d
./do_extra_stuff.sh: done printing positional arguments
```

```bash
$ ./params_play.sh -s "extra" -v -g "e" a b c d 

verbose is turned on
s_option is 'extra'
g_option is 'e'
positional_1 is 'a' (same as 'a')
positional_2 is 'b' (same as 'b')
printing out all of the other positional arguments:
positional_3 is c
positional_4 is d
done printing arguments
calling another function with arguments that were passed in
do_stuff param1 = 'a'
do_stuff param2 = 'b'
calling another script with arguments that were passed in
do_extra_stuff: n is '2'
./do_extra_stuff.sh: begin printing positional arguments
./do_extra_stuff.sh: positional_1 is a
./do_extra_stuff.sh: positional_2 is b
./do_extra_stuff.sh: positional_3 is c
./do_extra_stuff.sh: positional_4 is d
./do_extra_stuff.sh: done printing positional arguments
```
