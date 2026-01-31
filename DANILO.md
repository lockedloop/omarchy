# Danilo's Omarchy Customizations

This fork contains my personal customizations to Omarchy.

## Shell: Zsh + Oh-My-Zsh

Switched default shell from bash to zsh with oh-my-zsh.

**New files created:**

<!-- markdownlint-disable MD013 -->
| File | Purpose |
|------|---------|
| `default/zsh/rc` | Main entry point |
| `default/zsh/shell` | Zsh options, history settings |
| `default/zsh/init` | Tool initializations (starship, mise, zoxide) |
| `default/zsh/aliases` | Shell aliases |
| `default/zsh/functions` | Shell functions |
| `default/zsh/envs` | Environment variables |
| `default/zshrc` | User's zshrc template |
| `install/config/shell.sh` | Oh-my-zsh + plugins installer |
<!-- markdownlint-enable MD013 -->

**Oh-My-Zsh plugins:**

<!-- markdownlint-disable MD013 -->
- git, fzf, zsh-syntax-highlighting, zsh-autosuggestions
- zsh-history-substring-search, you-should-use, zsh-bat
<!-- markdownlint-enable MD013 -->

## Packages Added

### Development Tools

<!-- markdownlint-disable MD013 -->
| Package | Description |
|---------|-------------|
| `cmake` | Build system |
| `meson` | Build system |
| `ninja` | Fast build system |
| `just` | Modern command runner |
| `git-lfs` | Git Large File Storage |
| `visual-studio-code-bin` | VS Code editor |
| `tmux` | Terminal multiplexer |
<!-- markdownlint-enable MD013 -->

### Hardware Design (Verilog/VHDL)

<!-- markdownlint-disable MD013 -->
| Package | Description |
|---------|-------------|
| `verilator` | Verilog simulator |
| `gtkwave` | Waveform viewer |
| `yosys` | Verilog synthesis |
<!-- markdownlint-enable MD013 -->

### Browsers & Communication

<!-- markdownlint-disable MD013 -->
| Package | Description |
|---------|-------------|
| `brave-bin` | Brave browser |
| `telegram-desktop` | Telegram messenger |
| `slack-desktop` | Slack client |
<!-- markdownlint-enable MD013 -->

### Media & Graphics

<!-- markdownlint-disable MD013 -->
| Package | Description |
|---------|-------------|
| `vlc` | Media player |
| `drawio-desktop` | Diagram editor |
<!-- markdownlint-enable MD013 -->

### System Utilities

<!-- markdownlint-disable MD013 -->
| Package | Description |
|---------|-------------|
| `nwg-displays` | Multi-monitor GUI |
| `cliphist` | Clipboard history |
| `wl-clip-persist` | Persistent clipboard |
| `seahorse` | GNOME Keyring GUI |
| `qemu-full` | Full QEMU emulator |
| `virt-manager` | VM management GUI |
<!-- markdownlint-enable MD013 -->

### Fonts (10 Nerd Fonts)

<!-- markdownlint-disable MD013 -->
- Cascadia Mono, DejaVu, FiraCode, Hack, Inconsolata
- JetBrains Mono, Meslo, Roboto Mono, Source Code Pro, Ubuntu
<!-- markdownlint-enable MD013 -->

## Packages Removed

<!-- markdownlint-disable MD013 -->
- `1password-beta` - Not needed
<!-- markdownlint-enable MD013 -->

## Web Apps Changed

**Removed:**

<!-- markdownlint-disable MD013 -->
- Basecamp, Figma, Fizzy
- Google Photos, Google Contacts, Google Messages
<!-- markdownlint-enable MD013 -->

**Added:**

<!-- markdownlint-disable MD013 -->
| App | URL |
|-----|-----|
| Google Mail | https://mail.google.com |
| Google Calendar | https://calendar.google.com |
| Google Drive | https://drive.google.com |
| Claude | https://claude.ai |
| Gemini | https://gemini.google.com |
| Perplexity | https://perplexity.ai |
<!-- markdownlint-enable MD013 -->

**Kept:**

<!-- markdownlint-disable MD013 -->
- HEY, WhatsApp, Google Maps, ChatGPT, YouTube, GitHub, X, Discord, Zoom
<!-- markdownlint-enable MD013 -->

## Alacritty Configuration

Updated terminal with transparency and minimal decorations:

```toml
[window]
padding.x = 12
padding.y = 12
decorations = "None"
opacity = 0.9

[scrolling]
history = 10000

[selection]
save_to_clipboard = true

[mouse]
hide_when_typing = true
```

## Clipboard History

Added cliphist integration:

<!-- markdownlint-disable MD013 -->
- `wl-paste --watch cliphist store` in autostart
- `Super+Ctrl+V` opens clipboard history via Walker
<!-- markdownlint-enable MD013 -->

## Documentation Added

<!-- markdownlint-disable MD013 -->
| File | Description |
|------|-------------|
| `INSTALL.md` | Installation guide (ISO + manual) |
| `RELEASE.md` | Guide for creating custom releases |
| `DANILO.md` | This file - changelog of customizations |
<!-- markdownlint-enable MD013 -->
