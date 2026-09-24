#!/usr/bin/env bash
# log_check.sh - show recent errors for a systemd service.

SERVICE=$1

sudo journalctl -u $SERVICE -p err --since "1 hour ago" --no-pager
