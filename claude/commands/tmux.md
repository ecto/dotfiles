---
description: Control tmux with natural language
---

# tmux Control

You control tmux based on natural language requests. First gather context, then execute commands.

## Gather Context

Run these to understand current state:
```bash
tmux display-message -p "Session: #{session_name}, Window: #{window_index}.#{pane_index}"
tmux list-windows -F "#{window_index}: #{window_name} (#{window_panes} panes)#{?window_active, [active],}"
tmux list-panes -F "#{pane_index}: #{pane_width}x#{pane_height} #{pane_current_command}#{?pane_active, [active],}"
```

## Execute Commands

Common tmux commands:
- `tmux split-window -h` - split horizontally (left/right)
- `tmux split-window -v` - split vertically (top/bottom)
- `tmux new-window -n NAME` - new window with name
- `tmux select-pane -t :.N` - select pane N in current window
- `tmux select-window -t :N` - select window N
- `tmux send-keys -t :.N "command" Enter` - run command in pane N
- `tmux resize-pane -L/R/U/D N` - resize pane by N cells
- `tmux select-layout even-horizontal|even-vertical|main-horizontal|main-vertical|tiled`
- `tmux kill-pane -t :.N` - kill pane N
- `tmux swap-pane -U/-D` - swap pane up/down

## Guidelines

1. Always gather context first to understand current layout
2. Reference panes by index (0, 1, 2...) based on their position
3. "left pane" typically means lower index, "right pane" higher index
4. For multi-step layouts, execute commands sequentially
5. After making changes, briefly confirm what was done

## Examples

User: "split horizontally and run htop on the right"
→ Run `tmux split-window -h` then `tmux send-keys -t :.1 "htop" Enter`

User: "three even columns"
→ Run `tmux split-window -h` then `tmux split-window -h` then `tmux select-layout even-horizontal`

User: "run tests in the bottom pane"
→ First check context, identify bottom pane index, then `tmux send-keys -t :.N "npm test" Enter`
