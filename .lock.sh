#!/bin/bash
set -x

ICON=$HOME/.lock.icon.png
TMPBG=/tmp/screen.png
#scrot -e "mv \$f $TMPBG"
#xset dpms force off
pkill compton
sleep 1
#compton --dbus -Gf &
#convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG -scale 25% -scale 400% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
#$(sleep 0.06 && xset dpms force on) &
#disown
#i3lock -u -i $TMPBG --debug
#sleep 1
#pkill compton
