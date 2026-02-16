#!/bin/bash
# Simple keybind setup for Plasma
# Set these manually in System Settings → Shortcuts → Custom Shortcuts

cat << 'EOF'
===========================================
PLASMA KEYBIND SETUP GUIDE
===========================================

Open: System Settings → Shortcuts → Custom Shortcuts

Then create these:

1. Meta+Return → kitty
   - Edit → New → Global Shortcut → Command/URL
   - Trigger: Meta+Return
   - Action: kitty

2. Meta+E → yazi
   - New → Global Shortcut → Command/URL
   - Trigger: Meta+E
   - Action: kitty -e yazi

3. Meta+Q → Close Window
   - Go to: Shortcuts → KWin
   - Find "Close Window"
   - Add shortcut: Meta+Q

4. Meta+H/J/K/L → Window Navigation
   - In KWin shortcuts, search for:
     - "Window Focus Left" → Meta+H
     - "Window Focus Down" → Meta+J
     - "Window Focus Up" → Meta+K
     - "Window Focus Right" → Meta+L

Desktops (Meta+1-4) should already work!

===========================================
OR - Want me to keep trying to automate it?
===========================================
EOF
