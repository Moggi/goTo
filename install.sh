# !/usr/bin/bash

_GOTO_HOME="${HOME}/.goto"

echo '              ________
_______ _________  __/_____
__  __ `/  __ \_  /  _  __ \
_  /_/ // /_/ /  /   / /_/ /
_\__, / \____//_/    \____/
/____/

Simple way to pre-set up a terminal environment
'

if [ ! "`basename $SHELL`" == "bash" ]
then
    echo 'Looks like you have other SHELL environment'
    echo 'We are sourcing the goTo script to $HOME/.bash_profile'
    echo 'You may need to `source $HOME/.bash_profile` to your SHELL startup script'
fi

if [ -f gt.sh ]
then
	mkdir -p $_GOTO_HOME
    mkdir $_GOTO_HOME/envs
	cp -f gt.sh $_GOTO_HOME/gt.sh
    touch $_GOTO_HOME/places

    if [ ! -f $HOME/.bash_profile ] || ! grep -q "source ${_GOTO_HOME}/gt.sh" $HOME/.bash_profile
    then
        echo "source ${_GOTO_HOME}/gt.sh" >> $HOME/.bash_profile
    fi
    # Shell script can't source functions
    # Need to source manually
    echo ''
    echo 'To use now, you need to source it manually'
    echo 'or just initiate a new SHELL instance'
else
	echo 'No GOTO files found. [gt.sh]'
fi
