# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
git clone https://github.com/ecto/dotfiles ~/dotfiles
cd ~/dotfiles
brew install stow
./install.sh
```

## Structure

```
~/dotfiles/
├── bash/           # Bash configuration
│   └── .bashrc
├── vim/            # Vim configuration
│   ├── .vimrc
│   └── .vim/
├── tmux/           # Tmux configuration
│   ├── .tmux.conf
│   └── .tmux/
│       └── scripts/    # Status bar scripts
├── install.sh      # Installer (runs stow + installs TPM)
└── .gitignore
```

## How Stow Works

Stow creates symlinks from `~` to files in each package directory:

```
~/dotfiles/tmux/.tmux.conf  →  ~/.tmux.conf
~/dotfiles/vim/.vimrc       →  ~/.vimrc
```

### Common Commands

```bash
cd ~/dotfiles

# Install all packages
stow bash vim tmux

# Install single package
stow tmux

# Uninstall a package
stow -D tmux

# Reinstall (after moving files)
stow -R tmux

# Dry run (preview changes)
stow -n -v tmux
```

## Packages

### bash
- `.bashrc` - Bash shell configuration

### vim
- `.vimrc` - Vim configuration
- `.vim/` - Vim plugins (NERDTree, Powerline)

### tmux
- `.tmux.conf` - Tmux configuration
  - Prefix: `Ctrl-a` (changed from default `Ctrl-b`)
  - Mouse support enabled
  - Vi-style copy mode with system clipboard integration
  - Vim-style pane navigation (`hjkl`)
  - Intuitive splits: `|` vertical, `-` horizontal
  - Status bar at top with system info

- `.tmux/scripts/` - Status bar scripts (macOS)
  - `battery.sh` - Battery percentage and charging status
  - `cpu_mem.sh` - CPU and memory usage
  - `git_branch.sh` - Current git branch with dirty indicator
  - `vpn.sh` - VPN/Tailscale connection status
  - `weather.sh` - Current weather (cached 30min)
  - `k8s.sh` - Kubernetes context/namespace
  - `spotify.sh` - Currently playing track

### Tmux Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix (instead of `Ctrl-b`) |
| `Ctrl-a r` | Reload config |
| `Ctrl-a \|` | Split vertical |
| `Ctrl-a -` | Split horizontal |
| `Ctrl-h/j/k/l` | Navigate panes (no prefix, works in vim too!) |
| `Ctrl-a H/J/K/L` | Resize panes |
| `Ctrl-a o` | Session picker (sessionx) |
| `Ctrl-a f` | Floating pane toggle (floax) |
| `Ctrl-a Space` | Quick copy mode (thumbs) - select URLs, paths, etc. |
| `Ctrl-a [` | Enter copy mode |
| `v` (copy mode) | Begin selection |
| `y` (copy mode) | Copy to system clipboard |

### Tmux Plugins (via TPM)

- [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) - Sensible defaults
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) - Save/restore sessions
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) - Auto-save sessions
- [tmux-sessionx](https://github.com/omerxx/tmux-sessionx) - Fuzzy session/window picker
- [tmux-floax](https://github.com/omerxx/tmux-floax) - Floating popup panes
- [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) - Quick copy URLs, paths, hashes
- [catppuccin/tmux](https://github.com/catppuccin/tmux) - Beautiful Mocha theme

Install plugins inside tmux: `Ctrl-a I`

### vim-tmux-navigator

Seamlessly navigate between vim splits and tmux panes with `Ctrl-h/j/k/l`.
No prefix needed - works identically in both vim and tmux.

## Adding a New Package

1. Create package directory:
   ```bash
   mkdir -p ~/dotfiles/newpkg
   ```

2. Add dotfiles (mirror home directory structure):
   ```bash
   # For ~/.config/foo/config.toml:
   mkdir -p ~/dotfiles/newpkg/.config/foo
   mv ~/.config/foo/config.toml ~/dotfiles/newpkg/.config/foo/
   ```

3. Stow it:
   ```bash
   cd ~/dotfiles && stow newpkg
   ```

4. Add to `install.sh` PACKAGES array

## Notes

- Tmux plugins directory (`.tmux/plugins/`) is gitignored - TPM installs them
- Status bar scripts are macOS-specific (use `pmset`, `vm_stat`, etc.)
- Backups of replaced files are saved as `*.backup`
