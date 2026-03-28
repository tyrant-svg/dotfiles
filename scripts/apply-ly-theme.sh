#!/bin/bash
# Run with sudo: sudo bash ~/scripts/apply-ly-theme.sh
# RPG terminal aesthetic for ly login manager

CONFIG=/etc/ly/config.ini

sed -i \
    -e 's/^animation = .*/animation = gameoflife/' \
    -e 's/^gameoflife_fg = .*/gameoflife_fg = 0x00AAAAAA/' \
    -e 's/^bigclock = .*/bigclock = digital/' \
    -e 's/^clock = .*/clock = %H:%M/' \
    -e 's/^box_title = .*/box_title = [ SYSTEM LOGIN ]/' \
    -e 's/^hide_version_string = .*/hide_version_string = true/' \
    -e 's/^hide_key_hints = .*/hide_key_hints = true/' \
    -e 's/^hide_keyboard_locks = .*/hide_keyboard_locks = true/' \
    -e 's/^text_in_center = .*/text_in_center = true/' \
    -e 's/^blank_box = .*/blank_box = false/' \
    -e 's/^bg = .*/bg = 0x00000000/' \
    -e 's/^fg = .*/fg = 0x00CCCCCC/' \
    -e 's/^border_fg = .*/border_fg = 0x00FFFFFF/' \
    -e 's/^error_fg = .*/error_fg = 0x01FFFFFF/' \
    "$CONFIG"

echo "ly theme applied — restart ly or reboot to see changes"
