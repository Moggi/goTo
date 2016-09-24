# !/usr/bin/bash

_GOTO_HOME="${HOME}/.goto"

if [ -d $_GOTO_HOME ]
then
    rm -rf $_GOTO_HOME
fi

if [ -f $HOME/.bashrc ]
then
    echo "$(grep -v "[ -f ${_GOTO_HOME}/gt.sh ] && source ${_GOTO_HOME}/gt.sh" ${HOME}/.bashrc)" > $HOME/.bashrc
fi
