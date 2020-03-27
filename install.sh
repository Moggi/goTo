#!/bin/bash

_GOTO_HOME="$HOME/.goto"
_command="[[ -r \$HOME/.goto/gt.sh ]] && source \$HOME/.goto/gt.sh"

echo '              ________
_______ _________  __/_____
__  __ `/  __ \_  /  _  __ \
_  /_/ // /_/ /  /   / /_/ /
_\__, / \____//_/    \____/
/____/

Simple way to pre-set up a terminal environment
'

case "`basename $SHELL`" in
    'bash')
        startup='.bashrc'
        ;;
    'zsh')
        startup='.zshrc'
        ;;
    *)
        printf "%s\n" 'No compatible SHELL. Must be Zsh or Bash'
        exit 1
    ;;
esac


if [ -r gt.sh ]
then
    [ ! -d "$_GOTO_HOME/envs" ] && mkdir -p "$_GOTO_HOME/envs"
	cp -f gt.sh $_GOTO_HOME/gt.sh
    [ ! -f "$_GOTO_HOME/places" ] && touch "$_GOTO_HOME/places"

    if [ ! -w "$HOME/$startup" ] || ! grep -q "$_command" $HOME/$startup
    then
        printf "%s\n" "$_command" >> $HOME/$startup
    fi
    printf "%s\n" "To use now, you need to \`source \$HOME/$startup\`"
    printf "%s\n" 'or just initiate a new SHELL instance'
else
	printf "%s\n" 'No GOTO files found. [gt.sh]'
fi
