# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly:

1. **Do not** open a public issue
2. Email the maintainer directly or use GitHub's private vulnerability reporting
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

You can expect:

- Acknowledgment within 48 hours
- Status update within 7 days
- Credit in the fix (unless you prefer anonymity)

## Security Model

### Remote Installation

The quick install command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SilentGlasses/gnome_terminal_themes/main/install.sh)
```

This pattern executes code fetched from the internet. By using this method, you are trusting:

1. **This repository** - Code is only fetched from `github.com/SilentGlasses/gnome_terminal_themes`
2. **GitHub's infrastructure** - Content is served over HTTPS from `raw.githubusercontent.com`
3. **The maintainer** - That commits to this repository are reviewed and safe

### Safer Alternative

If you prefer not to pipe curl to bash, you can:

1. Clone the repository and inspect the code:
   ```bash
   git clone https://github.com/SilentGlasses/gnome_terminal_themes.git
   cd gnome_terminal_themes
   # Review install.sh and theme scripts
   ./install.sh
   ```

2. Download and review before executing:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/SilentGlasses/gnome_terminal_themes/main/install.sh -o install.sh
   # Review install.sh
   bash install.sh
   ```

### What the Scripts Do

- **install.sh**: Reads theme files, displays a menu, and uses `dconf` to add GNOME Terminal profiles
- **uninstall.sh**: Removes installed theme profiles via `dconf`
- **themes/*.sh**: Each contains color definitions and adds a single terminal profile

The scripts:

- Do NOT require root/sudo privileges
- Do NOT modify system files
- Do NOT install packages
- Do NOT access network (except remote install mode fetching from this repo)
- Only modify GNOME Terminal's `dconf` settings in your user profile

## Security Measures

This project implements several security measures:

- **Automated security scanning** via GitHub Actions (ShellCheck, Gitleaks, CodeQL)
- **Dependency updates** via Dependabot
- **PR validation** requiring passing security checks
- **No hardcoded secrets** in any scripts
- **HTTPS only** for all external requests

## Third-Party Dependencies

This project has minimal dependencies:

- **bash** - Script interpreter
- **dconf** - GNOME configuration tool (system package)
- **curl** - For remote installation only (system package)

No npm, pip, or other package manager dependencies are used in the main scripts.
