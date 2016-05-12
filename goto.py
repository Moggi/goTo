#!/usr/local/bin/python

import sys
import os
import json

HOME = os.path.expanduser("~")

_goTo_home_path = "/usr/local/opt/goTo"

def _help():
    print 'Usage: gt <project_name>'
    print 'Example: gt myProject'
    print 'goTo will cd for you'

paths = {}

if __name__=='__main__':

    argc = len(sys.argv)

    if argc <= 1:
        _help()
        exit(1)

    name = str(sys.argv[1]).lower()

    with open(_goTo_home_path+'/.environments', 'r') as f:
        son = f.read()
        f.close()
        paths = json.loads(son)

    with open(_goTo_home_path+'/.environments', 'w') as f:
        f.write(json.dumps(paths))
        f.close()

    if paths.has_key(name):
        exit(0)

exit(1)
