#!/bin/bash
# VPN/Network status (ASCII version)

# Check for Tailscale
if command -v tailscale &>/dev/null; then
    ts_status=$(tailscale status --json 2>/dev/null | grep -o '"BackendState":"[^"]*"' | cut -d'"' -f4)
    if [[ "$ts_status" == "Running" ]]; then
        echo "#[fg=green]VPN:TS#[fg=white]"
        exit 0
    fi
fi

# Check for common VPN interfaces
if ifconfig | grep -qE "^(utun|tun|tap|ppp)" 2>/dev/null; then
    echo "#[fg=green]VPN:ON#[fg=white]"
    exit 0
fi

# Check for WireGuard
if command -v wg &>/dev/null && wg show &>/dev/null 2>&1; then
    echo "#[fg=green]VPN:WG#[fg=white]"
    exit 0
fi

# No VPN detected
echo "#[fg=colour240]VPN:--#[fg=white]"
