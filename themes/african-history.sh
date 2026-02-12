#!/bin/bash
# GNOME Terminal Theme: African History
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="African History"
PROFILE_SLUG="african-history"
PROFILE_UUID="ed9771d7-6b2c-4dc5-b075-153657452fac"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='African History'
background-color='rgb(32,28,29)'
foreground-color='rgb(167,141,124)'
palette=['rgb(43,41,38)', 'rgb(195,91,72)', 'rgb(69,137,98)', 'rgb(229,192,39)', 'rgb(18,85,146)', 'rgb(77,71,117)', 'rgb(86,136,137)', 'rgb(255,255,255)', 'rgb(43,41,38)', 'rgb(195,91,72)', 'rgb(69,137,98)', 'rgb(229,192,39)', 'rgb(18,85,146)', 'rgb(77,71,117)', 'rgb(86,136,137)', 'rgb(255,255,255)']
use-theme-colors=false
use-theme-transparency=false
bold-is-bright=true
EOF

# Add profile to profile list
PROFILE_LIST=$(dconf read /org/gnome/terminal/legacy/profiles:/list)
if [ -z "$PROFILE_LIST" ]; then
    dconf write /org/gnome/terminal/legacy/profiles:/list "['$PROFILE_UUID']"
else
    # Check if profile already in list
    if ! echo "$PROFILE_LIST" | grep -q "$PROFILE_UUID"; then
        # Append new profile to the list (remove trailing bracket, add new item, close bracket)
        NEW_LIST=$(echo "$PROFILE_LIST" | sed "s/]$/, '$PROFILE_UUID']/")
        dconf write /org/gnome/terminal/legacy/profiles:/list "$NEW_LIST"
    fi
fi

echo "✓ Installed theme: African History"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'African History' profile"
