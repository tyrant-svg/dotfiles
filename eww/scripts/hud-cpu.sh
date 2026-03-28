#!/usr/bin/env bash
# CPU usage % — read two /proc/stat samples 200ms apart for accuracy
read_cpu() {
    awk '/^cpu / {print $2+$4, $2+$3+$4+$5}' /proc/stat
}
read -r idle1 total1 <<< "$(read_cpu)"
sleep 0.2
read -r idle2 total2 <<< "$(read_cpu)"
delta_total=$((total2 - total1))
delta_idle=$((idle2 - idle1))
if [ "$delta_total" -gt 0 ]; then
    printf "%d%%" $(( (delta_total - delta_idle) * 100 / delta_total ))
else
    echo "0%"
fi
