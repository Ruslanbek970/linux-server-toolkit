#!/usr/bin/env bash
# log_check.sh - show recent error-level log entries for a systemd service.
# Usage: log_check.sh <service> [since]
# Example: log_check.sh nginx "2 hours ago"
# Reading system logs may require sudo or membership in the systemd-journal group.

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <service> [since]" >&2
    echo "Example: $0 nginx \"2 hours ago\"" >&2
    exit 1
fi

SERVICE="$1"
SINCE="${2:-1 hour ago}"

if ! systemctl list-unit-files "${SERVICE}.service" --no-legend | grep -q .; then
    echo "Error: service '${SERVICE}' not found" >&2
    exit 1
fi

echo "Errors for ${SERVICE} since ${SINCE}:"
journalctl -u "$SERVICE" -p err --since "$SINCE" --no-pager
