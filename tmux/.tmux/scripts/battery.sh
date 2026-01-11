#!/bin/bash
# Battery status for macOS (ASCII version)

battery_info=$(pmset -g batt 2>/dev/null)
if [[ -z "$battery_info" ]]; then
    echo ""
    exit 0
fi

percentage=$(echo "$battery_info" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
charging=$(echo "$battery_info" | grep -q "charging\|AC Power" && echo "1" || echo "0")

if [[ -z "$percentage" ]]; then
    echo ""
    exit 0
fi

# Icon based on charging status
if [[ "$charging" == "1" ]]; then
    icon="BAT+"
else
    icon="BAT"
fi

# Color based on level
if [[ $percentage -le 20 ]]; then
    color="#[fg=red]"
elif [[ $percentage -le 40 ]]; then
    color="#[fg=yellow]"
else
    color="#[fg=green]"
fi

echo "${color}${icon} ${percentage}%#[fg=white]"
