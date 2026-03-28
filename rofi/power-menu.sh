#!/bin/bash
case "$1" in
    " Lock")       hyprlock ;;
    " Suspend")    systemctl suspend ;;
    " Reboot")     systemctl reboot ;;
    "󰐥 Shutdown")  systemctl poweroff ;;
    " Logout")     hyprctl dispatch exit ;;
    *)
        echo " Lock"
        echo " Suspend"
        echo " Reboot"
        echo "󰐥 Shutdown"
        echo " Logout"
        ;;
esac
