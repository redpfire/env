#!/bin/sh

# key repeat rate
xset r rate 200 30

# set tapping on touchpad
xinput set-prop 16 315 1

${WM:=qtile}

[ -e $HOME/.wm ] && WM=`cat $HOME/.wm`

[ $WM = "berry" ] && sxhkd -c $HOME/.config/berry/sxhkdrc &

exec $WM
