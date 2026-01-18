#!/bin/bash
# Dotfiles installer using GNU Stow

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU Stow is not installed. Install with: brew install stow"
    exit 1
fi

echo "Installing dotfiles from $DOTFILES_DIR"

cd "$DOTFILES_DIR"

# Packages to stow
declare -a PACKAGES=(
    "bash"
    "vim"
    "tmux"
    "ghostty"
)

stow "${PACKAGES[@]}"

# Install TPM if not present
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "Run 'prefix + I' inside tmux to install plugins"
fi

# Symlink Claude Code skills
if [[ -d "$HOME/.claude/commands" ]]; then
    echo "Installing Claude Code skills..."
    for skill in "$DOTFILES_DIR"/claude/commands/*.md; do
        [[ -e "$skill" ]] || continue
        ln -sf "$skill" "$HOME/.claude/commands/"
    done
fi

echo "Done! Restart your shell or run: source ~/.bashrc"
