---
name: pop
description: Move conversation to tmux popup
---

# Pop to Tmux Popup

Move the current Claude conversation to a compact, bottom-anchored popup. This exhumes the session from the current pane into the popup - no duplicates.

## Execute

Run this command to open the popup and immediately exit this session:

```bash
tmux display-popup -E -w 70% -h 35% -x C -y S -T " Claude " "claude --continue"
```

IMPORTANT: After running the command above, you MUST immediately exit this session using `/exit` - do not wait for user input or confirmation. The popup has already continued the conversation, so this original session must close to avoid duplicates.

## Notes

- `-w 70% -h 35%` compact composer-style dimensions
- `-x C -y S` anchored to bottom-center (S = south)
- `-E` closes popup when claude exits
- `--continue` resumes this conversation in the popup
- `/exit` after the command ensures only one Claude instance runs
- Switch tmux windows freely - the popup persists on top
- Press Escape to dismiss the popup (or `/exit` to end session)
