#!/usr/local/bin/python

import sys
import os
import json

class GoTo():
    _HOMEPATH = ""
    _ENVPATH = ""
    _PATHS = {}

    def __init__(self):
        self._HOMEPATH = os.path.expanduser("~")
        self._ENVPATH = self._HOMEPATH+'/.goTo.envs'

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
        print '\tgt [-alr] <project> [path]\n'
        print 'USAGE'
        print '\tgt <project>           \t cd to a project'
        print '\tgt -l                  \t list projects and paths'
        print '\tgt -r <project>        \t remove a project'
        print '\tgt -a <project> <path> \t add a project with a path (can use . or ..)\n'
        print 'AUTHOR'
        print '\tgoTo was made by Paulo Moggi and the source can be found at:'
        print '\thttps://github.com/Moggi/goTo\n'
        print 'goTo\t\t\t\t12/05/2016\t\t\t\tgoTo'

    def ls(self):
        for key, value in self._PATHS.iteritems():
            print '[' + key + '] => ' + value

    def up(self,name):
        if self._PATHS.has_key(name):
            return True

        print 'Project name don\'t exist.'
        return False

    def add(self,name,path):
        if self._PATHS.has_key(name):
            print 'Project name already exist.'
            print 'Doing nothing.'

        else:
            path = os.path.abspath(path)

            if path[-1] != '/':
                path+='/'

            self._PATHS[name] = os.path.expanduser(path)
            self._write_file()

    def rm(self,name):
        if not self._PATHS.has_key(name):
            print 'Project name don\'t exist.'
            print 'Doing nothing.'

        else:
            del self._PATHS[name]
            self._write_file()


if __name__=='__main__':

    _ARGS = sys.argv
    _NARG = len(_ARGS)

    _CMD_  = 1
    _NAME_ = 2
    _PATH_ = 3

    goTo = GoTo()

    if _NARG <= 1:
        goTo.usage()
        exit(1)

    elif _NARG == 2:
        if _ARGS[_CMD_][0] != '-':
            if goTo.up(_ARGS[_NAME_-1]):
                exit(0)
        else:
            if _ARGS[_CMD_] != '--ls' or _ARGS[_CMD_] != '-ls':
                goTo.ls()

    else:
        if _ARGS[_CMD_] == '--add' or _ARGS[_CMD_] == '-a':
            goTo.add(_ARGS[_NAME_],_ARGS[_PATH_])

        elif _ARGS[_CMD_] == '--rm' or _ARGS[_CMD_] == '-r':
            goTo.rm(_ARGS[_NAME_])

        else:
            goTo.usage()


exit(1)
