#!/usr/bin/env python3
import os, subprocess

if __name__ == '__main__':
    for f in ['.vim', '.vimrc']:
        cmd = "cp -r {0} {1}/{0}".format(f, os.environ['HOME'])
        print(cmd)
        subprocess.call(cmd.split())
