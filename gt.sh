
function gt {
    _goTo_home="/usr/local/opt/goto"

    python "${_goTo_home}/goto.py" $*
    if [ "$?" -eq 0 ]
    then
        _goTo_path=$(cat "$HOME/.goTo.envs" | jsawk "return this.$1")
        cd $_goTo_path
    fi
}
