#!/usr/bin/env bash
# service_check.sh - quick health check for a web service.
# Follows the diagnostic pipeline: service -> process -> port -> local HTTP.
# Usage: service_check.sh [service] [port]
# Example: service_check.sh nginx 80

set -euo pipefail

SERVICE="${1:-nginx}"
PORT="${2:-80}"
FAILED=0

check() {
    local name="$1"
    shift
    if "$@" > /dev/null 2>&1; then
        echo "[OK]   $name"
    else
        echo "[FAIL] $name"
        FAILED=1
    fi
}

echo "Checking ${SERVICE} on port ${PORT}..."

check "service ${SERVICE} is active" systemctl is-active --quiet "$SERVICE"
check "process ${SERVICE} is running" pgrep -x "$SERVICE"
check "port ${PORT} is listening" bash -c "ss -tln | grep -q ':${PORT} '"
check "local HTTP request succeeds" curl -fsS "http://localhost:${PORT}"

if [[ $FAILED -ne 0 ]]; then
    echo "Some checks failed. See docs/troubleshooting.md or run: journalctl -u ${SERVICE} -n 50"
    exit 1
fi

echo "All checks passed."