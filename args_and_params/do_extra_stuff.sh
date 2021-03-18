#!/usr/bin/env bash

unset CDPATH;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )";

########################################################################
#
# print_help ()
#
# print the help message
#
########################################################################

function print_help() {

    cat << EOF
usage: $( basename $0 ) [options] [positional_1 ...]

Play with argument parsing in bash.

OPTIONS:

-n <number>                     set n to some number
-h                              Print this help message.

EOF
    exit $?;
}


# setup reasonable defaults for command line options
n=0;

# parse the command line arguments, which consists of:
# 1. option flags
# 2. option values
# 3. positional arguments
# a colon after the option flag means it takes an option value

options=":hn:";

# keep track of the number of option values as nNamedArgs
# and positional arguments as nUnnamedArgs
let nNamedArgs=0;
let nUnnamedArgs=0;

# put the named arguments into an array called namedArgs
# put the unnamed arguments into an array called unnamedArgs
while (( "$#" ))
do
    case $1 in
        -h )
            # parse options without values
            namedArgs[$nNamedArgs]=$1;
            let nNamedArgs++;
            shift;
            ;;
        -n )
            # parse options with values
            namedArgs[$nNamedArgs]=$1;
            let nNamedArgs++;
            shift;
            namedArgs[$nNamedArgs]=$1;
            let nNamedArgs++;
            shift;
            ;;
        * )
            # unrecognized arguments
            unnamedArgs[$nUnnamedArgs]=$1;
            let nUnnamedArgs++;
            shift;
            ;;
    esac
done

# perform actions based on which named arguments were set
# convert the named arguments (option values) to variables
while getopts "${options}" Option "${namedArgs[@]}"
do
   case $Option in
      n ) n=$OPTARG;;
      h ) print_help;;
   esac
done

# set script to exit if any of the commands below
# return an error status code.
set -e;

echo "do_extra_stuff: n is '${n}'";

source ${DIR}/tools.sh
print_positionals $0 unnamedArgs

exit 0;
