#!/bin/bash

bin=/usr/local/bin

if [[ x"$1" != x && -f $bin/$1 && -x $bin/$1 ]]; then
    exec $@
else
    echo 'Usage: docker run -it bacnet <command> <args>'
    echo '... where <command> is one of:'
    ls -C $bin
    exit 1
fi
