#!/bin/bash

HOMEDIR=
GITDIR="$(git rev-parse --show-toplevel 2>/dev/null)"

if [ -d $HOME ]; then
    HOMEDIR=$HOME
elif [ -d $1 ]; then
    HOMEDIR=$1
else
    echo Please pass your home directory\'s path as the first command line argument
    exit 1
fi

ln -s $GITDIR/home/.bashrc $HOMEDIR/.bashrc
ln -s $GITDIR/home/.bash   $HOMEDIR/.bash
