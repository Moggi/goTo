# !/usr/bin/bash

_GOTO_HOME="${HOME}/.goto"

rm -f $_GOTO_HOME/goto.py
rm -f $_GOTO_HOME/gt.sh

if [ -f $HOME/.bash_profile ]
then
    echo "$(grep -v "source ${_GOTO_HOME}/gt.sh" ${HOME}/.bash_profile)" > $HOME/.bash_profile
fi
