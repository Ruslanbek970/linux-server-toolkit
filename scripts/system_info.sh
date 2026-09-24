#!/usr/bin/env bash
# system_info.sh - print a short overview of the server state.
# Usage: ./scripts/system_info.sh

set -euo pipefail

section() {
    echo
    echo "==== $1 ===="
}

section "User and host"
echo "User:     $(whoami)"
echo "Hostname: $(hostname)"

section "OS and kernel"
uname -a

section "Network interfaces"
ip -brief addr

section "Disk usage"
df -h /

section "Memory"
free -h

section "Uptime"
uptime