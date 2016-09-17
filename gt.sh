
function gt {

    _GOTO_ENVS="$HOME/.goto/envs"
    _GOTO_PLACES="$HOME/.goto/places"
    _ERROR="No such file or directory"
    _GOTO_EDITOR="nano"

    function __cd {
        _DIR=$(grep -w "$1" $_GOTO_PLACES | cut -d: -f2)
        if [ -z ${DIR+x} ] && [ -d $_DIR ]
        then
            cd $_DIR
        else
            echo $_ERROR
        fi
    }

    function __eval {
        if [ -f $_GOTO_ENVS/$1 ]
        then
            while IFS='' read -r line || [[ -n "$line" ]]; do
                eval "$line"
            done < "$_GOTO_ENVS/$1"
        else
            echo "There is nothing in the GoTo environment file $_GOTO_ENVS/$1"
        fi
    }

    function __ls {
        TAB=$'\t'
        cat $_GOTO_PLACES | sed "s/:/${TAB}/g"
    }

    function __add {
        if [ "$1" = "ls" ] || [ "$1" = "help" ]
        then
            echo "There is a command with this name"
            echo "This project name can't be used"
        elif [ $(grep -w "$1" $_GOTO_PLACES) ]
        then
            echo "gt rm '$1' before anything"
        else
            echo "$1:$2" >> $_GOTO_PLACES
            sort $_GOTO_PLACES -o $_GOTO_PLACES
            echo "Now you can edit the environment file at $_GOTO_ENVS/$1"
        fi
    }


    function __edit {
        if [ ! -z ${GOTO_EDITOR+x} ]
        then
            _GOTO_EDITOR=$GOTO_EDITOR
        fi
		if [ $(grep -w "$1" $_GOTO_PLACES) ]
        then
            echo "Editing \"$1\" project env"
            eval "$_GOTO_EDITOR $_GOTO_ENVS/$1"
        else
            echo $_ERROR
        fi
    }

    function __rm {
        if [ -d $_GOTO_ENVS/$1 ]
        then
            rm -f $_GOTO_ENVS/$1
        fi
        echo "$(grep -vw "$1" ${_GOTO_PLACES})" > $_GOTO_PLACES
    }

    function __help {
echo 'Mini "man gt"
NAME
    goTo -- Simple way to pre-set up a terminal environment

USAGE
    gt                          see the goTo logo
    gt <project>                cd to a project
    gt ls                       list projects and paths
    gt help                     print this help
    gt up <project>             setup the project environment
    gt rm <project>             remove a project
    gt add <project> <path>     add a project with a path
    gt edit <project>     		edit environment file for project

ENVIRONMENT
    GOTO_EDITOR May be used to specify default environment editor

AUTHOR
    goTo was made by Paulo Moggi and the source can be found at:
    https://github.com/Moggi/goTo

goTo				08/09/2016				goTo'
    }

    function __logo {
echo '              ________
_______ _________  __/_____
__  __ `/  __ \_  /  _  __ \
_  /_/ // /_/ /  /   / /_/ /
_\__, / \____//_/    \____/
/____/

Simple way to pre-set up a terminal environment

do `gt help` to see the help
'
    }


    if [ ! -d "$HOME/.goto/" ]
    then
        # Shell script can't unset functions
        # Need to unset manually
        echo 'goTo was not (un)installed properly to this instance'
        echo 'You need to `unset -f gt` to remove it or just initiate a new SHELL instance'
        return 1
    fi

    if (( $# == 0 ))
    then
        __logo
    elif (( $# == 1 ))
    then
        if [ $1 = "ls" ]
        then
            __ls
        elif [ $1 = "help" ]
        then
            __help
        else
            __cd $1
        fi
    elif (( $# == 2 ))
    then
        if [ $1 = "up" ]
        then
            __eval $2
        elif [ $1 = "rm" ]
        then
            __rm $2

        elif [ $1 = "edit" ]
        then
            __edit $2
        fi
    elif (( $# == 3 ))
    then
        if [ $1 = "add" ]
        then
            __add $2 $3
        fi
    fi

    return 0
}
