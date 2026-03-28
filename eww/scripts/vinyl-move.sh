#!/usr/bin/env bash
# vinyl-move.sh — move the vinyl widget via keybind
# usage: vinyl-move.sh <up|down|left|right>

STEP=30

get_val() {
    eww get "$1" | tr -d 'px'
}

DIR="$1"
X=$(get_val vinyl-x)
Y=$(get_val vinyl-y)

case "$DIR" in
    up)    Y=$((Y - STEP)) ;;
    down)  Y=$((Y + STEP)) ;;
    left)  X=$((X - STEP)) ;;
    right) X=$((X + STEP)) ;;
    *) echo "usage: vinyl-move.sh <up|down|left|right>"; exit 1 ;;
esac

eww update vinyl-x="${X}px"
eww update vinyl-y="${Y}px"
