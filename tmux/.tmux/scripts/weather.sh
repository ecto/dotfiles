#!/bin/bash
# Weather using wttr.in (cached to avoid rate limiting)

CACHE_FILE="/tmp/tmux_weather_cache"
CACHE_TTL=1800  # 30 minutes

# Check if cache exists and is fresh
if [[ -f "$CACHE_FILE" ]]; then
    cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
    if [[ $cache_age -lt $CACHE_TTL ]]; then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Fetch weather (format: icon + temp)
weather=$(curl -s --max-time 2 "wttr.in/?format=%c%t" 2>/dev/null | tr -d '+')

if [[ -n "$weather" && ! "$weather" =~ "Unknown" && ! "$weather" =~ "error" ]]; then
    echo "$weather" > "$CACHE_FILE"
    echo "$weather"
else
    # Return cached value if fetch failed
    [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" || echo ""
fi
