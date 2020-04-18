#!/bin/sh

. $HOME/.zprofile

xsetroot -cursor_name ptr_left

# key repeat rate
xset r rate 200 30

# set tapping on touchpad
xinput set-prop 16 315 1

# enable natural scrolling
# xinput set-prop 16 297 1

# reload Xresources
xrdb ~/.Xresources

setxkbmap pl -option caps:super

if [ ! -e "$HOME/.env/.var/plain_wallpaper" ]; then
    if [ -e "$HOME/.wall.png" ]; then
        feh --bg-fill $HOME/.wall.png
    elif [ -e "$HOME/.wall.jpg" ]; then
        feh --bg-fill $HOME/.wall.jpg
    fi
else
    : ${BGCOLOR:="#131313"}
    [ -e "$HOME/.env/.var/color" ] && BGCOLOR="`cat $HOME/.env/.var/color`"
    xsetroot -bg "$BGCOLOR" -cursor_name ptr_left
fi

: ${WM:=qtile}
[ -e $HOME/.env/.var/wm ] && WM=`cat $HOME/.env/.var/wm`

[ $WM = "berry" ] && sxhkd -c $HOME/.config/berry/sxhkdrc &

exec $WM
