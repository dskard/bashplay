########################################################################
#
# do_stuff()
#
# accepts 2 parameters and print them out
#
# Example: do_stuff param1 param2
#
########################################################################

function do_stuff() {

    local param1=$1
    local param2=$2

    # should probably check that we got 2 parameters

    echo "do_stuff param1 = '${param1}'";
    echo "do_stuff param2 = '${param2}'";
}


########################################################################
#
# print_positionals()
#
# print positional arguments from a script
# accepts 2 arguments:
# 1. script name
# 2. array of positional arguments
#
# Example: do_stuff $0 ${unnamedArgs[@]}
#
# Notes for passing arrays to functions:
# https://stackoverflow.com/a/26443029
#
########################################################################

function print_positionals () {
    local script_name=$1
    local -n positionals=$2

    echo "${script_name}: begin printing positional arguments"
    let index=1;
    for value in "${positionals[@]}"
    do
        echo "${script_name}: positional_${index} is ${value}";
        let index++;
    done

    echo "${script_name}: done printing positional arguments"
}

