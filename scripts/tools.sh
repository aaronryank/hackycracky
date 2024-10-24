#!/bin/bash

TOOLDIR="$hc/GitRepo/apt/tools"
TOOLLIST="$TOOLDIR/$1.list"

if [ ! "$1" ]; then
  echo "Tool groups: "
  for f in $(find /home/aaron/HackyCracky/GitRepo/apt/tools -type f); do
    echo `basename "${f%%.*}"`
  done
  exit 0
fi

if [ ! -f "$TOOLLIST" ]; then
  echo "Tool group not fount!"
  exit 1
fi

cat $TOOLLIST
