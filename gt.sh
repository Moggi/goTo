
function gt {
    _goTo_home="/usr/local/opt/goto"

    python "${_goTo_home}/goto.py" $1
    if [ "$?" -eq 0 ]
    then
        _goTo_path=$(cat "${_goTo_home}/.environments" | jsawk "return this.$1")
        cd $_goTo_path
    fi
}
