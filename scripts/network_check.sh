#!/usr/bin/env bash
# network_check.sh - basic network diagnostics for a server.
# Usage: network_check.sh [host]
# Example: network_check.sh google.com

set -euo pipefail

HOST="${1:-google.com}"

echo "==== IP addresses ===="
ip -brief addr

echo
echo "==== Default route ===="
ip route | grep default || echo "No default route"

echo
echo "==== DNS lookup for ${HOST} ===="
dig +short "$HOST" || echo "DNS lookup failed"

echo
echo "==== Ping ${HOST} ===="
ping -c 3 "$HOST" || echo "Host is not reachable"

echo
echo "==== Listening ports ===="
ss -tuln
