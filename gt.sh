
function gt {
    _GOTO_HOME="${HOME}/.goto"

    if [ ! -d $_GOTO_HOME ] || [ ! -f ${_GOTO_HOME}/goto.py ]
    then
        echo 'goTo files not found. Unsetting this function'
        unset -f gt
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
