#!/usr/bin/env bash
# Active network interface name, or "offline"
iface=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}' | head -1)
[ -n "$iface" ] && echo "$iface" || echo "offline"
