#!/bin/bash

#
# Creation du fichier : /lib/udev/rules.d/99-nico-sound-toggle.rules 
# Contenu : SUBSYSTEM=="drm", ACTION=="change", RUN+="/usr/local/bin/SoundToggle"
#

#USERID="$(cat /var/run/ConsoleKit/database | grep -B 6 is_active= | grep uid= | cut -f 2 -d '=')"
#USERID="$(id -u)"

#USER="$(grep $USERID /etc/passwd | cut -f 1 -d ':')"
#USER="$(whoami)"

HDMI_STATUS="$(cat /sys/class/drm/card0-HDMI-A-1/status)"

#export PULSE_SERVER='unix:/run/user/'$USER'/pulse/native'
#export DISPLAY=":0"

if [ "${HDMI_STATUS}" = connected ]; then
    #sudo -u $USER pactl set-card-profile 0 output:hdmi-stereo
    #sudo -u $USER notify-send -i computer -t 5000 "Notification" "HDMI connected"
    pactl set-card-profile 0 output:hdmi-stereo
    notify-send -i computer -t 5000 "Notification" "HDMI connected"
else
    #sudo -u $USER pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
    #sudo -u $USER notify-send -i computer -t 5000 "Notification" "HDMI disconnected"
    pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
    notify-send -i computer -t 5000 "Notification" "HDMI disconnected"
fi

exit 0
