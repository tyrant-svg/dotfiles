#!/usr/bin/env bash
# music.sh — polls playerctl and updates eww variables
# Run once: eww daemon will handle the loop via `listen` command

ART_CACHE="$HOME/.cache/vinyl-art"
PLACEHOLDER="$ART_CACHE/placeholder.png"
CURRENT_ART="$ART_CACHE/current.png"

mkdir -p "$ART_CACHE"

# Generate placeholder disc if it doesn't exist
if [[ ! -f "$PLACEHOLDER" ]]; then
    python3 - <<'PY'
import os
from PIL import Image, ImageDraw
SIZE = 300
BG = (22, 19, 11)
img = Image.new('RGBA', (SIZE, SIZE), (*BG, 255))
draw = ImageDraw.Draw(img)
cx = cy = SIZE // 2
# grooves
for r in range(40, 140, 6):
    v = 35 + r // 8
    draw.ellipse((cx-r, cy-r, cx+r, cy+r), outline=(v, v, v+4, 160), width=1)
# center circle
draw.ellipse((cx-10, cy-10, cx+10, cy+10), fill=(40, 40, 40, 255))
img.save(os.path.expanduser("~/.cache/vinyl-art/placeholder.png"), "PNG")
print("placeholder created")
PY
fi

fetch_art() {
    local url="$1"
    if [[ -z "$url" ]]; then
        cp "$PLACEHOLDER" "$CURRENT_ART"
        return
    fi
    if [[ "$url" == file://* ]]; then
        local path="${url#file://}"
        # extract embedded art with ffmpeg if it's an audio file
        if ffmpeg -y -i "$path" -an -vcodec copy "$CURRENT_ART" 2>/dev/null; then
            return
        else
            cp "$PLACEHOLDER" "$CURRENT_ART"
            return
        fi
    fi
    # HTTP(S) — Spotify CDN etc.
    if curl -sL --max-time 6 -o "$CURRENT_ART.tmp" "$url" 2>/dev/null; then
        # validate it's actually an image
        if python3 -c "from PIL import Image; Image.open('$CURRENT_ART.tmp').verify()" 2>/dev/null; then
            mv "$CURRENT_ART.tmp" "$CURRENT_ART"
            return
        fi
    fi
    cp "$PLACEHOLDER" "$CURRENT_ART"
}

update_eww() {
    # single playerctl call — ensures status/artist/title all come from the same player
    local data status artist title art_url
    data="$(playerctl metadata --format '{{status}}|{{artist}}|{{title}}|{{mpris:artUrl}}' 2>/dev/null)"

    if [[ -z "$data" ]]; then
        echo "Stopped" > "$ART_CACHE/status"
        eww update music-artist=""
        eww update music-title="Nothing playing"
        eww update music-art="$PLACEHOLDER"
        eww update music-status="Stopped"
        return
    fi

    IFS='|' read -r status artist title art_url <<< "$data"
    fetch_art "$art_url"

    # save status for rotate.sh to read without spawning playerctl
    echo "$status" > "$ART_CACHE/status"

    eww update music-artist="$artist"
    eww update music-title="$title"
    eww update music-art="$CURRENT_ART"
    eww update music-status="$status"
}

case "$1" in
    --listen)
        # event-driven loop via playerctl --follow
        update_eww
        playerctl --follow metadata --format '{{status}}|{{artist}}|{{title}}|{{mpris:artUrl}}' 2>/dev/null | \
        while IFS='|' read -r status artist title art_url; do
            fetch_art "$art_url"
            echo "$status" > "$ART_CACHE/status"
            eww update music-artist="$artist"
            eww update music-title="$title"
            eww update music-art="$CURRENT_ART"
            eww update music-status="$status"
        done
        ;;
    --status)
        playerctl status 2>/dev/null || echo "Stopped"
        ;;
    --artist)
        playerctl metadata artist 2>/dev/null || echo ""
        ;;
    --title)
        playerctl metadata title 2>/dev/null || echo "Nothing playing"
        ;;
    --art)
        echo "$CURRENT_ART"
        ;;
    --prev)
        playerctl previous
        ;;
    --next)
        playerctl next
        ;;
    --toggle)
        playerctl play-pause
        ;;
    *)
        update_eww
        ;;
esac
