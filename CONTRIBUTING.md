# Contributing to GNOME Terminal Themes

Thank you for your interest in contributing! This guide will help you get started.

## Ways to Contribute

- **Add new themes** - Create and submit terminal color schemes
- **Fix bugs** - Help improve the installer/uninstaller scripts
- **Improve documentation** - Clarify instructions or add examples
- **Report issues** - Let us know about problems you encounter

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a feature branch: `git checkout -b feature/my-new-theme`
4. Make your changes
5. Test thoroughly
6. Commit with a clear message
7. Push and open a Pull Request

## Adding a New Theme

### Theme File Structure

Create a new file in `themes/` with this structure:

```bash
#!/bin/bash
# GNOME Terminal Theme: Your Theme Name
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Your Theme Name"
PROFILE_SLUG="your-theme-name"
PROFILE_UUID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # Generate with: uuidgen

dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Your Theme Name'
background-color='rgb(R,G,B)'
foreground-color='rgb(R,G,B)'
palette=['rgb(...)', 'rgb(...)', ...]  # 16 colors
use-theme-colors=false
use-theme-transparency=false
bold-is-bright=true
EOF

# Add profile to profile list
PROFILE_LIST=$(dconf read /org/gnome/terminal/legacy/profiles:/list)
if [ -z "$PROFILE_LIST" ]; then
    dconf write /org/gnome/terminal/legacy/profiles:/list "['$PROFILE_UUID']"
else
    if ! echo "$PROFILE_LIST" | grep -q "$PROFILE_UUID"; then
        NEW_LIST=$(echo "$PROFILE_LIST" | sed "s/]$/, '$PROFILE_UUID']/")
        dconf write /org/gnome/terminal/legacy/profiles:/list "$NEW_LIST"
    fi
fi

echo "✓ Installed theme: Your Theme Name"
```

### Naming Conventions

- **File names**: lowercase, hyphen-separated (e.g., `ocean-breeze-dark.sh`)
- **Profile names**: Title case (e.g., "Ocean Breeze Dark")
- **Variants**: Use `-dark`, `-light`, `-day`, `-night` suffixes

### Color Palette

The palette array must contain exactly 16 colors in this order:

| Index | Standard Color | Index | Bright Color  |
|-------|----------------|-------|---------------|
| 0     | Black          | 8     | Bright Black  |
| 1     | Red            | 9     | Bright Red    |
| 2     | Green          | 10    | Bright Green  |
| 3     | Yellow         | 11    | Bright Yellow |
| 4     | Blue           | 12    | Bright Blue   |
| 5     | Magenta        | 13    | Bright Magenta|
| 6     | Cyan           | 14    | Bright Cyan   |
| 7     | White          | 15    | Bright White  |

### Testing Your Theme

1. Run ShellCheck: `shellcheck themes/your-theme.sh`
2. Test installation: `bash install.sh` and select your theme
3. Verify it appears in GNOME Terminal → Preferences
4. Test uninstallation: `bash uninstall.sh`

## Code Guidelines

### Shell Scripts

- Use `#!/usr/bin/env bash`
- Quote all variables: `"$variable"` not `$variable`
- Use `[[ ]]` for conditionals (bash-specific)
- Run ShellCheck and fix all warnings
- Avoid hardcoded paths

### Commit Messages

Use clear, descriptive commit messages:

- `feat: add ocean-breeze theme`
- `fix: correct palette color order in nord-dark`
- `docs: update installation instructions`
- `chore: update CI workflow`

## Pull Request Process

1. Ensure all CI checks pass
2. Fill out the PR template completely
3. Include screenshots for new themes
4. Respond to review feedback promptly
5. Squash commits if requested

## Questions?

Open an issue if you have questions or need help!
