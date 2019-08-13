#!/bin/sh

[ -n "`realpath --relative-to=$HOME/.env -z $0 | grep hooks`" ] && \
    echo "+ Running hook `basename $0`"

die()
{
    echo $1 1>&2
    exit 1
}

sym_f()
{
    [ -e $2 ] && rm $2
    _sym $1 $2
}

sym()
{
    [ -e $2 ] && return
    _sym $1 $2
}

_sym()
{
    ln -sf $1 $2
}
