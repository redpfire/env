#!/bin/sh

# key repeat rate
xset r rate 200 30

${WM:=qtile}

[ -e $HOME/.wm ] && WM=`cat $HOME/.wm`

[ $WM = "berry" ] && sxhkd -c $HOME/.config/berry/sxhkdrc &

exec $WM
