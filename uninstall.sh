# !/usr/bin/bash

_GOTO_HOME="${HOME}/.goto"

if [ -d $_GOTO_HOME ]
then
    rm -rf $_GOTO_HOME
fi

if [ -f $HOME/.bash_profile ]
then
    echo "$(grep -vw "source ${_GOTO_HOME}/gt.sh" ${HOME}/.bash_profile)" > $HOME/.bash_profile
fi
