#!/bin/bash
# Currently playing track from Spotify (macOS)

if ! pgrep -x "Spotify" > /dev/null; then
    echo ""
    exit 0
fi

state=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)

if [[ "$state" != "playing" ]]; then
    echo ""
    exit 0
fi

artist=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
track=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)

if [[ -n "$artist" && -n "$track" ]]; then
    # Truncate if too long
    display="$artist - $track"
    if [[ ${#display} -gt 35 ]]; then
        display="${display:0:32}..."
    fi
    echo "#[fg=green] ${display}#[fg=white]"
else
    echo ""
fi
