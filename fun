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

ask() {
    # $1 - message
    # $2 - default option

    if [ "$2" = "y" ]; then
        echo "$1? [Y/n]: \c"
        read c
        if [ "$c" = "y" ] || [ "$c" = "Y" ] || [ -z "$c" ]; then
            return 0
        else
            return 1
        fi
    else
        echo "$1? [y/N]: \c"
        read c
        if [ "$c" = "N" ] || [ "$c" = "n" ] || [ -z "$c" ]; then
            return 1
        else
            return 0
        fi
    fi
}
