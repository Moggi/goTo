# !/bin/bash

_GOTO_HOME="$HOME/.goto"
_command="[[ -r \$HOME/.goto/gt.sh ]] && source \$HOME/.goto/gt.sh"

if [ -d $_GOTO_HOME ]
then
    rm -rf $_GOTO_HOME
fi

if [ -w $HOME/.bashrc ]; then
    # printf "%s\n" "$(grep -v $_command ${HOME}/.bashrc)" > $HOME/.bashrc
    printf "%s\n" "$(grep -v $_command ${HOME}/.bashrc)"
fi

if [ -w $HOME/.zshrc ]; then
    # printf "%s\n" "$(grep -v $_command ${HOME}/.zshrc)" > $HOME/.zshrc
    printf "%s\n" "$(grep -v $_command ${HOME}/.zshrc)"
fi
