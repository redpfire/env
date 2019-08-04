#!/bin/sh

# key repeat rate
xset r rate 200 30

[ -e $HOME/.wm ] && exec `cat $HOME/.wm`
exec qtile
