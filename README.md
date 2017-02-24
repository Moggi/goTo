# goTo
```
              ________      
_______ _________  __/_____
__  __ `/  __ \_  /  _  __ \
_  /_/ // /_/ /  /   / /_/ /
_\__, / \____//_/    \____/
/____/                      

Simple way to pre-set up a terminal environment                                     
```

## Quick start

1. Clone the repo and install it
 ```sh
 git clone https://github.com/Moggi/goTo.git
 cd goTo

 chmod +x install.sh
 ./install.sh
 ```

2. Do `gt help` to see the mini manual
 ```sh
 # do gt help to see the help
 gt help
 # or gt to see the 'goTo logo'
 gt
 ```

### Uninstall  
```sh
chmod +x uninstall.sh
./uninstall.sh
```

### Where it runs
- Bash
- Zsh

## How it works

__goTo__ operates over the current user shell so the user can change the directory, source files and export variables to current environment. To do this job, goTo needs to be a function and not a script ([Stackoverflow Thread](http://stackoverflow.com/a/1464266))

### Changing directories
With __goTo__ you can easily `cd` to a project by typing `gt <project_name>`. Example:
```sh
# lets say you are at $HOME
cd ~
# and you have a POV-Ray project at $HOME/Code/povray
gt add povray $HOME/Code/povray
# now you can just go there with
gt povray

# Now let's say you need to cd to a project at /usr/local/share/projectX/
# if you have already saved it, then
gt projectX
```

### Predefined environments
Another feature is the possibility to use goTo to setup a environment with a simple file with your commands  
**IMPORTANT**: goTo will read line by line executing with `eval`, so your command needs to be in one line
```sh
# lets say every time you will work on a Hadoop project, you need to make two alias
alias hstart='./giant/path/to/your/project/with/hadoop/projectH/start-all.sh'
alias hstop='./giant/path/to/your/project/with/hadoop/projectH/stop-all.sh'
# but you don't work on the project every day, so it's not at your ~/.bash_profile or similar
# so every time you need to put those commands...

# Now you only need to put these guys at a file and call goTo to setup them to you
gt edit projectH
# It will open the nano editor (you can change this with 'export GOTO_EDITOR="you_editor"')
# write your ONE LINE COMMAND (must be a command in one line)
 alias hstart='./giant/path/../projectH/start-all.sh'
 alias hstop='./giant/path/../projectH/stop-all.sh'
# Simply call goTo and you're good to go
gt up projectH
```
