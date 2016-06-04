
function gt {
    _GOTO_HOME="${HOME}/.goto"

    if [ ! -d $_GOTO_HOME ] || [ ! -f ${_GOTO_HOME}/goto.py ]
    then
        # Shell script can't unset functions
        # Need to unset manually
        echo 'goTo was not (un)installed properly to this instance'
        echo 'You need to `unset -f gt` to remove it or just initiate a new SHELL instance'
        return 1
    fi

    python "${_GOTO_HOME}/goto.py" $*
    if [ "$?" -eq 0 ]
    then
        _goTo_path=$(cat "${_GOTO_HOME}/envs" | jsawk "return this.$1")
        cd $_goTo_path
    fi
    return 0
}
