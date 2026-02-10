#!/bin/bash
#
# Danilo's Omarchy Customizations
# Run this AFTER a stock Omarchy installation to apply all personal changes.
#
# Usage:
#   bash <(curl -s https://raw.githubusercontent.com/lockedloop/omarchy/dev/danilo-setup.sh)
#
set -eEo pipefail

OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"

echo "==> Applying Danilo's Omarchy customizations..."

# ─── Remove unwanted packages ────────────────────────────────────────────────

echo "==> Removing unwanted packages..."
yay -Rns --noconfirm 1password-beta 2>/dev/null || true

# ─── Install additional packages ─────────────────────────────────────────────

echo "==> Installing additional packages..."
yay -S --needed --noconfirm \
  zsh \
  cmake meson ninja just git-lfs visual-studio-code-bin tmux \
  verilator gtkwave yosys \
  telegram-desktop \
  vlc drawio-desktop \
  nwg-displays cliphist wl-clip-persist seahorse \
  qemu-full virt-manager \
  ttf-dejavu-nerd ttf-firacode-nerd ttf-hack-nerd ttf-inconsolata-nerd \
  ttf-meslo-nerd ttf-roboto-mono-nerd ttf-sourcecodepro-nerd ttf-ubuntu-nerd

# ─── Install oh-my-zsh + plugins ────────────────────────────────────────────

echo "==> Setting up zsh + oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

declare -A plugins=(
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
  [zsh-history-substring-search]="https://github.com/zsh-users/zsh-history-substring-search.git"
  [you-should-use]="https://github.com/MichaelAquilina/zsh-you-should-use.git"
  [zsh-bat]="https://github.com/fdellwing/zsh-bat.git"
)

for name in "${!plugins[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
    echo "    Installing $name..."
    git clone "${plugins[$name]}" "$ZSH_CUSTOM/plugins/$name"
  fi
done

# ─── Zsh config files ───────────────────────────────────────────────────────

echo "==> Installing zsh configuration..."
mkdir -p "$OMARCHY_PATH/default/zsh"

cat > "$HOME/.zshrc" << 'ZSHRC'
# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Starship handles the prompt

plugins=(
    git
    fzf
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    you-should-use
    zsh-bat
)

source $ZSH/oh-my-zsh.sh

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/zsh/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
ZSHRC

# Set zsh as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "==> Changing default shell to zsh..."
  sudo chsh -s /bin/zsh "$USER"
fi

# ─── Alacritty config ───────────────────────────────────────────────────────

echo "==> Updating Alacritty config..."
ALACRITTY_CONF="$HOME/.config/alacritty/alacritty.toml"
if [ -f "$ALACRITTY_CONF" ]; then
  # Update padding
  sed -i 's/^padding\.x = .*/padding.x = 12/' "$ALACRITTY_CONF"
  sed -i 's/^padding\.y = .*/padding.y = 12/' "$ALACRITTY_CONF"

  # Add opacity, scrolling, selection, mouse settings if not present
  if ! grep -q 'opacity' "$ALACRITTY_CONF"; then
    sed -i '/^decorations = "None"/a opacity = 0.9' "$ALACRITTY_CONF"
  fi

  if ! grep -q '\[scrolling\]' "$ALACRITTY_CONF"; then
    cat >> "$ALACRITTY_CONF" << 'EOF'

[scrolling]
history = 10000
multiplier = 3

[selection]
save_to_clipboard = true

[mouse]
hide_when_typing = true
EOF
  fi
fi

# ─── Clipboard history (cliphist) ───────────────────────────────────────────

echo "==> Setting up clipboard history..."
AUTOSTART="$HOME/.config/hypr/autostart.conf"
if [ -f "$AUTOSTART" ] && ! grep -q 'cliphist' "$AUTOSTART"; then
  echo 'exec-once = wl-paste --watch cliphist store' >> "$AUTOSTART"
fi

# ─── Update web apps ────────────────────────────────────────────────────────

echo "==> Updating web apps..."
# Remove stock web apps we don't want
for app in "Basecamp" "Figma" "Fizzy" "Google Photos" "Google Contacts" "Google Messages"; do
  omarchy-webapp-remove "$app" 2>/dev/null || true
done

# Install custom web apps
omarchy-webapp-install "Google Mail" https://mail.google.com/ "Google Mail.png" 2>/dev/null || true
omarchy-webapp-install "Google Calendar" https://calendar.google.com/ "Google Calendar.png" 2>/dev/null || true
omarchy-webapp-install "Google Drive" https://drive.google.com/ "Google Drive.png" 2>/dev/null || true
omarchy-webapp-install "Claude" https://claude.ai/ "Claude.png" 2>/dev/null || true
omarchy-webapp-install "Gemini" https://gemini.google.com/ "Gemini.png" 2>/dev/null || true
omarchy-webapp-install "Perplexity" https://perplexity.ai/ "Perplexity.png" 2>/dev/null || true

# ─── Update uwsm env for zsh ────────────────────────────────────────────────

echo "==> Updating mise activation for zsh..."
UWSM_ENV="$HOME/.config/uwsm/env"
if [ -f "$UWSM_ENV" ]; then
  sed -i 's/mise activate bash/mise activate zsh/' "$UWSM_ENV"
fi

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
echo "==> Done! Customizations applied."
echo "    - Log out and back in (or reboot) for zsh to take effect"
echo "    - Run 'omarchy-restart-waybar' to refresh the bar"
