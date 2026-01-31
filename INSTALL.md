# Installing Omarchy

There are two ways to install Omarchy: using a pre-built ISO (recommended) or installing on an existing Arch Linux system.

## Option 1: Build and Install from ISO (Recommended)

The ISO provides a complete offline installation experience with all packages pre-bundled.

### Building Your Custom ISO

1. **Clone the ISO builder**

   ```bash
   git clone https://github.com/omacom-io/omarchy-iso.git
   cd omarchy-iso
   git submodule update --init
   ```

2. **Build with your custom fork**

   ```bash
   # Point to your fork and branch
   OMARCHY_INSTALLER_REPO="your-username/omarchy" \
   OMARCHY_INSTALLER_REF="dev" \
   ./bin/omarchy-iso-make
   ```

   The ISO will be created in `./release/omarchy-*.iso`

### Build Options

<!-- markdownlint-disable MD013 -->
| Option | Description |
|--------|-------------|
| `--local-source` | Build using your local `$OMARCHY_PATH` (for testing) |
| `--dev` | Build from the development branch |
<!-- markdownlint-enable MD013 -->

### Environment Variables

<!-- markdownlint-disable MD013 -->
| Variable | Default | Description |
|----------|---------|-------------|
| `OMARCHY_INSTALLER_REPO` | `basecamp/omarchy` | GitHub repository in `owner/repo` format |
| `OMARCHY_INSTALLER_REF` | `master` | Git branch, tag, or commit to include |
<!-- markdownlint-enable MD013 -->

### Testing Your ISO

```bash
# Boot the ISO in a VM for testing
./bin/omarchy-iso-boot ./release/omarchy-*.iso
```

### Additional ISO Commands

<!-- markdownlint-disable MD013 -->
| Command | Description |
|---------|-------------|
| `./bin/omarchy-iso-make` | Build the ISO |
| `./bin/omarchy-iso-boot [iso]` | Test ISO in a VM |
| `./bin/omarchy-iso-sign [gpg-user] [iso]` | Sign the ISO with GPG |
| `./bin/omarchy-iso-upload [iso]` | Upload ISO (requires rclone config) |
| `./bin/omarchy-iso-release` | Build, sign, and upload in one step |
<!-- markdownlint-enable MD013 -->

### Installing from the ISO

1. Write the ISO to a USB drive:
   ```bash
   sudo dd if=./release/omarchy-*.iso of=/dev/sdX bs=4M status=progress
   ```

2. Boot from the USB drive

3. The Omarchy Installer launches automatically and guides you through:
   - Disk partitioning
   - User account creation
   - System installation
   - First boot into Hyprland

## Option 2: Install on Existing Arch Linux

If you already have Arch Linux installed, you can add Omarchy on top.

### Prerequisites

<!-- markdownlint-disable MD013 -->
- A working Arch Linux installation with network access
- A non-root user account with sudo privileges
<!-- markdownlint-enable MD013 -->

### Installation

```bash
# Install from the official repository
bash <(curl -s https://omarchy.com/install)

# Or install from your custom fork
OMARCHY_REPO="your-username/omarchy" \
OMARCHY_REF="dev" \
bash <(curl -s https://omarchy.com/install)
```

### What the Installer Does

<!-- markdownlint-disable MD013 -->
1. Clones the repository to `~/.local/share/omarchy/`
2. Installs all packages from `install/omarchy-base.packages`
3. Installs oh-my-zsh and plugins
4. Copies configurations to `~/.config/`
5. Sets up themes, services, and autostarts
6. Changes default shell to zsh
7. Configures the display manager (SDDM)
8. Reboots into Hyprland
<!-- markdownlint-enable MD013 -->

## Post-Installation

After installation, you can:

<!-- markdownlint-disable MD013 -->
- Change theme: `omarchy-theme-set <theme-name>`
- Change font: `omarchy-font-set <font-name>`
- Update system: `omarchy-update`
- List all commands: `compgen -c | grep -E '^omarchy-' | sort -u`
<!-- markdownlint-enable MD013 -->

## Troubleshooting

### View Installation Logs

```bash
sudo cat /var/log/omarchy-install.log
```

### Reinstall Configurations

```bash
omarchy-reinstall-configs
```

### Manual Installation

For advanced users who want full control, see the [Manual Installation Guide](https://learn.omacom.io/2/the-omarchy-manual/96/manual-installation).

## Resources

<!-- markdownlint-disable MD013 -->
- [Omarchy ISO Builder](https://github.com/omacom-io/omarchy-iso)
- [The Omarchy Manual](https://learn.omacom.io/2/the-omarchy-manual)
- [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
<!-- markdownlint-enable MD013 -->
