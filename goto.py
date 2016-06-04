#!/usr/local/bin/python

import sys
import os
import json

class GoTo():
    _HOMEPATH = ""
    _GOTOHOME = ""
    _ENVPATH = ""
    _PATHS = {}

    def __init__(self):
        self._HOMEPATH = os.path.expanduser("~")
        self._GOTOHOME = self._HOMEPATH+'/.goto'
        self._ENVPATH = self._GOTOHOME+'/envs'

        if not self._file_exist():
            self._create_file()
        else:
            self._read_file()

    ## FILE
    def _create_file(self):
        with open(self._ENVPATH, 'w') as f:
            f.write(json.dumps({}))
            f.close()

    def _read_file(self):
        with open(self._ENVPATH, 'r') as f:
            self._PATHS = json.loads(f.read())
            f.close()

    def _write_file(self):
        with open(self._ENVPATH, 'w') as f:
            f.write(json.dumps(self._PATHS))
            f.close()

    def _file_exist(self):
        return os.path.isfile(self._ENVPATH)

    ## Future implementation
    # def get_env(self,name):
    #
    # def set_env(self,name,path):
    #

    ## Commands
    def usage(self):
        print 'Mini \'man gt\'\n'
        print 'NAME'
        print '\tgoTo -- change dir to a specific project path\n'
        print 'SYNOPSIS'
        print '\tgt [-ahlr] <project> [path]\n'
        print 'USAGE'
        print '\tgt <project>           \t cd to a project'
        print '\tgt -l                  \t list projects and paths'
        print '\tgt -h                  \t print this help'
        print '\tgt -r <project>        \t remove a project'
        print '\tgt -a <project> <path> \t add a project with a path (can use . or ..)\n'
        print 'AUTHOR'
        print '\tgoTo was made by Paulo Moggi and the source can be found at:'
        print '\thttps://github.com/Moggi/goTo\n'
        print 'goTo\t\t\t\t03/06/2016\t\t\t\tgoTo'

    def ls(self):
        for key, value in self._PATHS.iteritems():
            print '[' + key + ']\t=> ' + value

    def up(self,name):
        if self._PATHS.has_key(name):
            return True

        print 'Project name don\'t exist.'
        return False

    def add(self,name,path):
        if name[0]=='-':
            print 'Project name can\'t initiate with \'-\''
            print 'Doing nothing.'
            return

        if self._PATHS.has_key(name):
            print 'Project name already exist.'
            print 'Doing nothing.'

        else:
            path = os.path.abspath(path)

            if path[-1] != '/':
                path+='/'

            if os.path.isdir(path):
                self._PATHS[name] = os.path.expanduser(path)
                self._write_file()
            else:
                print 'Invalid path.'
                print 'Doing nothing.'

    def rm(self,name):
        if not self._PATHS.has_key(name):
            print 'Project name don\'t exist.'
            print 'Doing nothing.'

        else:
            del self._PATHS[name]
            self._write_file()

    def logo(self):
        print '              ________'
        print '_______ _________  __/_____'
        print '__  __ `/  __ \_  /  _  __ \\'
        print '_  /_/ // /_/ /  /   / /_/ /'
        print '_\__, / \____//_/    \____/'
        print '/____/\n'
        print 'Simple way to pre-set up a terminal environment\n'
        print 'do `gt -h` to see the help'

def _main(_ARGS):
    _NARG = len(_ARGS)

    _CMD_  = 1
    _NAME_ = 2
    _PATH_ = 3

    goTo = GoTo()

    if _NARG <= 1:
        goTo.logo()
        return 1

    # gt <name>
    if  _ARGS[_CMD_][0] != '-':
        if goTo.up(_ARGS[_NAME_-1]):
            return 0
    else:
        #gt <cmd>
        if _ARGS[_CMD_] == '--ls' or _ARGS[_CMD_] == '-l':
            goTo.ls()
            return 1

        elif _ARGS[_CMD_] == '--help' or _ARGS[_CMD_] == '-h':
            goTo.usage()
            return 1

        # gt <cmd> <name>
        elif (_ARGS[_CMD_] == '--rm' or _ARGS[_CMD_] == '-r') and _NARG>2:
            goTo.rm(_ARGS[_NAME_])
            return 1

        # gt <cmd> <name> <path>
        elif (_ARGS[_CMD_] == '--add' or _ARGS[_CMD_] == '-a') and _NARG>3:
            goTo.add(_ARGS[_NAME_],_ARGS[_PATH_])
            return 1

    goTo.usage()
    return 1


exit(_main(sys.argv))
