#!/usr/bin/env bash
# vinyl-listen.sh — runs in background, feeds playerctl events into eww variables
# Called by: eww.yuck script block OR hyprland autostart
# Restart-safe: exits cleanly if eww daemon isn't running

exec ~/.config/eww/scripts/music.sh --listen
