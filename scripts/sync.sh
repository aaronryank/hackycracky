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

PATHOF_BASHRC="$HOMEDIR/.bashrc"
PATHOF_BASHDIR="$HOMEDIR/.bash"

if [ -e $PATHOF_BASHRC ]; then
    rm $PATHOF_BASHRC
fi
if [ -e $PATHOF_BASHDIR ]; then
    if [ -d $PATHOF_BASHDIR ]; then
        rm -r $PATHOF_BASHDIR
    else
        rm $PATHOF_BASHDIR
    fi
fi


ln -s $GITDIR/home/.bashrc $HOMEDIR/.bashrc
ln -s $GITDIR/home/.bash   $HOMEDIR/.bash

echo "Please remember to source your .bashrc!"
echo " ---         source ~/bashrc        ---"
