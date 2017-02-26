# !/usr/bin/bash

_GOTO_HOME="$HOME/.goto"

echo '              ________
_______ _________  __/_____
__  __ `/  __ \_  /  _  __ \
_  /_/ // /_/ /  /   / /_/ /
_\__, / \____//_/    \____/
/____/

Simple way to pre-set up a terminal environment
'

if [ "`basename $SHELL`" = "bash" ]
then
    startup='.bashrc'
elif [ "`basename $SHELL`" = "zsh" ]
then
    startup='.zshrc'
else
    echo 'No compatible SHELL. Must be Zsh or Bash'
    exit 1
fi

if [ -f gt.sh ]
then
    [ ! -d "$_GOTO_HOME/envs" ] && mkdir -p "$_GOTO_HOME/envs"
	cp -f gt.sh $_GOTO_HOME/gt.sh
    [ ! -f "$_GOTO_HOME/places" ] && touch "$_GOTO_HOME/places"

    _command="\n[[ -r $_GOTO_HOME/gt.sh ]] && source $_GOTO_HOME/gt.sh\n"
    if [ ! -f "$HOME/$startup" ] || ! grep -q "$_command" $HOME/$startup
    then
        echo "$_command" >> $HOME/$startup
    fi
    echo "To use now, you need to \`source \$HOME/$startup\`"
    echo 'or just initiate a new SHELL instance'
else
	echo 'No GOTO files found. [gt.sh]'
fi
