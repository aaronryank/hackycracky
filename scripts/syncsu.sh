#!/bin/bash

if [ -z "$hcg" ]; then
    echo "Please source repo/home/.bash/defs and repo/home/.bash/functions prior to running script!"
    exit 1
fi

ROOT_BASHRC="/root/.bashrc"
ROOT_BASHDIR="/root/.bash"

if [ -e $ROOT_BASHRC ]; then
    rm $ROOT_BASHRC
fi
if [ -e $ROOT_BASHDIR ]; then
    rm $ROOT_BASHDIR
fi

sudo ln -s $hcg/home/.bashrc /root/.bashrc
sudo ln -s $hcg/home/.bash /root/.bash
