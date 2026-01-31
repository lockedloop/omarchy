# Creating a Custom Omarchy Release

This guide explains how to fork and customize Omarchy for your own distribution or personal use.

## Environment Variables

Omarchy supports two environment variables for custom installations:

<!-- markdownlint-disable MD013 -->
| Variable | Default | Description |
|----------|---------|-------------|
| `OMARCHY_REPO` | `omarchy/omarchy` | GitHub repository in `owner/repo` format |
| `OMARCHY_REF` | `main` | Git branch, tag, or commit to install |
<!-- markdownlint-enable MD013 -->

### Example: Installing from a Fork

```bash
OMARCHY_REPO="yourname/omarchy-fork" OMARCHY_REF="my-custom-branch" bash <(curl -s https://omarchy.com/install)
```

## Customization Areas

### Package Modifications

Edit `install/omarchy-base.packages` to add or remove packages. This file contains one package name per line and is used during installation.

### Shell Configuration (Zsh + Oh-My-Zsh)

Omarchy uses zsh with oh-my-zsh as the default shell. The configuration hierarchy:

<!-- markdownlint-disable MD013 -->
1. **Oh-My-Zsh** (`~/.oh-my-zsh/`) - Base framework and plugins
2. **Default configs** (`~/.local/share/omarchy/default/zsh/`) - Omarchy's shell defaults (read-only)
3. **User's zshrc** (`~/.zshrc`) - User customizations
<!-- markdownlint-enable MD013 -->

#### Default Zsh Configuration Files

<!-- markdownlint-disable MD013 -->
| File | Purpose |
|------|---------|
| `default/zsh/rc` | Main entry point, sources all other configs |
| `default/zsh/shell` | Zsh options (setopt), history settings |
| `default/zsh/init` | Tool initializations (starship, mise, zoxide) |
| `default/zsh/aliases` | Shell aliases |
| `default/zsh/functions` | Shell functions |
| `default/zsh/envs` | Environment variables |
<!-- markdownlint-enable MD013 -->

#### Default Oh-My-Zsh Plugins

<!-- markdownlint-disable MD013 -->
- `git` - Git aliases and functions
- `fzf` - Fuzzy finder integration
- `zsh-syntax-highlighting` - Command syntax highlighting
- `zsh-autosuggestions` - Fish-like autosuggestions
- `zsh-history-substring-search` - Better history search with arrow keys
- `you-should-use` - Reminds you of aliases you've defined
- `zsh-bat` - bat integration for cat replacement
<!-- markdownlint-enable MD013 -->

#### Customizing Oh-My-Zsh

To add or remove plugins, edit the `plugins` array in `~/.zshrc`:

```zsh
plugins=(
    git
    fzf
    zsh-syntax-highlighting
    zsh-autosuggestions
    # Add more plugins here
)
```

To add custom oh-my-zsh plugins, clone them to `~/.oh-my-zsh/custom/plugins/`.

### Theme Customization

Create custom themes in `~/.config/omarchy/themes/<name>/`. See existing themes in `themes/` for the required structure.

### Automation Hooks

Add custom scripts to `~/.config/omarchy/hooks/`:

<!-- markdownlint-disable MD013 -->
| Hook | Triggered |
|------|-----------|
| `theme-set` | After `omarchy-theme-set` applies a new theme |
| `font-set` | After `omarchy-font-set` changes the font |
| `post-update` | After `omarchy-update` completes |
<!-- markdownlint-enable MD013 -->

## Creating Your Own Release

1. **Fork the repository**

   ```bash
   gh repo fork omarchy/omarchy
   ```

2. **Make your customizations**

<!-- markdownlint-disable MD013 -->
   - Modify packages in `install/omarchy-base.packages`
   - Add custom themes to `themes/`
   - Modify default configs in `default/`
   - Add installation scripts to `install/config/`
<!-- markdownlint-enable MD013 -->

3. **Update version**

   Edit the `version` file to track your custom version.

4. **Test your changes**

   ```bash
   OMARCHY_REPO="yourname/omarchy-fork" OMARCHY_REF="your-branch" bash <(curl -s https://omarchy.com/install)
   ```

5. **Distribute**

   Share your installation command with users, pointing to your fork.

## Migration System

<!-- markdownlint-disable MD013 -->
When updating Omarchy, the `migrations/` directory contains timestamped shell scripts that run once per system. Each migration handles config updates, new dependencies, or one-time setup tasks.
<!-- markdownlint-enable MD013 -->

To add a migration for your fork:

```bash
omarchy-dev-add-migration --no-edit
```

This creates a new timestamped migration script in `migrations/`.

## Important Notes

<!-- markdownlint-disable MD013 -->
- **Never modify** `~/.local/share/omarchy/` directly - changes are lost on update
- **Always read from** `~/.local/share/omarchy/` for understanding defaults
- Keep bin/ scripts as bash - they don't need to be zsh
- Test on a fresh installation before distributing
<!-- markdownlint-enable MD013 -->
