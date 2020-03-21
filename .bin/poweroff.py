#!/bin/env python3
import os, subprocess
fd = os.open('/dev/input/event3', 0)
while True:
    os.read(fd, 512)
    try:
        r = subprocess.check_output('dmenu -b -p "Power off" -nb "#101010" -sb "#ff0000" <<< `printf "Abort\\nPoweroff\\nReboot"`', shell=True, executable="/bin/bash").strip().decode('utf8')
        if r == 'Poweroff':
            os.system('poweroff')
        elif r == 'Reboot':
            os.system('reboot')
    except:
        pass
