#!/bin/bash
# Set NVIDIA to max performance on Sway startup
# Note: nvidia-smi power commands run via systemd service (nvidia-performance.service)

# Wait for compositor to initialize
sleep 2

# Set performance mode via nvidia-settings (works with XWayland)
if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
    # Try to set PowerMizer to max performance
    nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1' >/dev/null 2>&1
fi
