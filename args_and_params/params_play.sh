#!/usr/bin/env bash

unset CDPATH;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )";

########################################################################
#
# error ()
#
# print an error message and exit with error status code
#
########################################################################

function error () {
    echo "${1}";
    exit 1;
}

########################################################################
#
# print_help ()
#
# print the help message
#
########################################################################

function print_help() {

    cat << EOF
usage: $( basename $0 ) [options] positional_1 positional_2 [positional_3 ...]

Play with argument parsing in bash.

OPTIONS:

-s <s-option>                   set the s variable to s-option
-g <g-option>                   set the g variable to g-option
-h                              Print this help message.
-v                              Verbose

EOF
    exit $?;
}

# setup reasonable defaults for optional and required command line arguments
s_option="more";
g_option="";
verbose=false;
positional_1="";
positional_2="";

# parse the command line arguments, which consists of:
# 1. option flags
# 2. option values
# 3. positional arguments
# a colon after the option flag means it takes an option value

options=":s:g:hv";

# keep track of the number of option values as nNamedArgs
# and positional arguments as nUnnamedArgs
let nNamedArgs=0;
let nUnnamedArgs=0;

# put the named arguments into an array called namedArgs
# put the unnamed arguments into an array called unnamedArgs
while (( "$#" ))
do
    case $1 in
        -h | -v )
            # parse options without values
            namedArgs[$nNamedArgs]=$1;
            let nNamedArgs++;
            shift;
            ;;
        -s | -g )
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
      s ) s_option=$OPTARG;;
      g ) g_option=$OPTARG;;
      h ) print_help;;
      v ) verbose="true";;
   esac
done

# set script to exit if any of the commands below
# return an error status code.
set -e;

# check if at least 2 required positional arguments were provided
if [[ ${nUnnamedArgs} < 2 ]]
then
    error "missing positional arguments";
else
    positional_1=${unnamedArgs[0]}
    positional_2=${unnamedArgs[1]}
fi

if $verbose
then
    echo "verbose is turned on";
fi

echo "s_option is '${s_option}'";
echo "g_option is '${g_option}'";
echo "positional_1 is '${positional_1}' (same as '${unnamedArgs[0]}')";
echo "positional_2 is '${positional_2}' (same as '${unnamedArgs[1]}')";

echo "printing out all of the other positional arguments:"
let index=3;
for value in "${unnamedArgs[@]:2}"
do
    echo "positional_${index} is ${value}";
    let index++;
done

echo "done printing arguments"

echo "calling another function with arguments that were passed in"
source ${DIR}/tools.sh
do_stuff ${positional_1} ${positional_2}

echo "calling another script with arguments that were passed in"
eval "./do_${s_option}_stuff.sh -n 2 ${positional_1} ${positional_2} ${unnamedArgs[@]:2}"

exit $?;
