#!/usr/bin/env python3
"""
rotate.py — renders a circular vinyl disc frame with optional rotation
Args: input_path angle output_path
"""
import sys, os
from PIL import Image, ImageDraw

src   = sys.argv[1]
angle = float(sys.argv[2])
dst   = sys.argv[3]
SIZE  = 300
BG    = (22, 19, 11)

try:
    img = Image.open(src).convert('RGBA').resize((SIZE, SIZE), Image.LANCZOS)
except Exception:
    img = Image.new('RGBA', (SIZE, SIZE), (*BG, 255))

cx = cy = SIZE // 2

# darken groove area (outer ring, keep label area clear)
label_r = int(SIZE * 0.28)
dark  = Image.new('RGBA', (SIZE, SIZE), (0, 0, 0, 160))
lmask = Image.new('L',    (SIZE, SIZE), 255)
ImageDraw.Draw(lmask).ellipse(
    (cx - label_r, cy - label_r, cx + label_r, cy + label_r), fill=0
)
img = Image.composite(dark, img, lmask)

# circular crop (alpha mask)
cmask = Image.new('L', (SIZE, SIZE), 0)
ImageDraw.Draw(cmask).ellipse((0, 0, SIZE - 1, SIZE - 1), fill=255)
out = Image.new('RGBA', (SIZE, SIZE), (0, 0, 0, 0))
out.paste(img, mask=cmask)

# spindle hole
hr = max(4, int(SIZE * 0.03))
ImageDraw.Draw(out).ellipse((cx - hr, cy - hr, cx + hr, cy + hr), fill=(0, 0, 0, 255))

# rotate (angle advances when Playing)
out = out.rotate(-angle, resample=Image.BICUBIC, expand=False)
out.save(dst, 'PNG')
