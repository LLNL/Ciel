#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH/clang-examples/Ciel-plugin
if [ $1 == "clean" ]; then
    make clean
else
    make && make install
fi