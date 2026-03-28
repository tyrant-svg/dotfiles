#!/usr/bin/env bash
# rotate.sh — advance angle, render circular frame, return path for eww defpoll

CACHE="$HOME/.cache/vinyl-art"
ANGLE_FILE="$CACHE/angle"
STATUS_FILE="$CACHE/status"
ART="$CACHE/current.png"
PLACEHOLDER="$CACHE/placeholder.png"

# double buffer — alternate output file to force GTK image reload
BUF_FILE="$CACHE/buf"
buf=$(cat "$BUF_FILE" 2>/dev/null || echo "0")
if [[ "$buf" == "0" ]]; then
    FRAME="$CACHE/frame_0.png"
    echo "1" > "$BUF_FILE"
else
    FRAME="$CACHE/frame_1.png"
    echo "0" > "$BUF_FILE"
fi

# read state
angle=$(cat "$ANGLE_FILE" 2>/dev/null || echo "0")
status=$(cat "$STATUS_FILE" 2>/dev/null || echo "Stopped")

# advance angle only when playing
if [[ "$status" == "Playing" ]]; then
    angle=$(awk "BEGIN {printf \"%.1f\", ($angle + 3.6) % 360}")
    echo "$angle" > "$ANGLE_FILE"
fi

src="$ART"
[[ -f "$src" ]] || src="$PLACEHOLDER"
[[ -f "$src" ]] || { echo "$PLACEHOLDER"; exit 0; }

python3 ~/.config/eww/scripts/rotate.py "$src" "$angle" "$FRAME" 2>/dev/null

echo "$FRAME"
