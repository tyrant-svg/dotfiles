#!/usr/bin/env bash
# RAM used/total
free -h | awk '/^Mem:/ {printf "%s/%s", $3, $2}'
