#!/bin/bash
# Git branch for current pane's directory (ASCII version)

pane_path="$1"

if [[ -z "$pane_path" ]]; then
    echo ""
    exit 0
fi

cd "$pane_path" 2>/dev/null || exit 0

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo ""
    exit 0
fi

branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

if [[ -z "$branch" ]]; then
    echo ""
    exit 0
fi

# Check for uncommitted changes
if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty="*"
else
    dirty=""
fi

# Truncate if too long
if [[ ${#branch} -gt 20 ]]; then
    branch="${branch:0:17}..."
fi

echo "#[fg=magenta]git:${branch}${dirty}#[fg=white]"
