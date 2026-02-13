#!/bin/bash
# GNOME Terminal Theme: Retro Green
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Retro Green"
PROFILE_SLUG="retro-green"
PROFILE_UUID="d8b987c4-0880-4de3-88f7-8abb925ee315"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Retro Green'
background-color='rgb(19,36,27)'
foreground-color='rgb(30,209,116)'
palette=['rgb(24,48,36)', 'rgb(28,127,76)', 'rgb(32,185,108)', 'rgb(36,234,143)', 'rgb(30,147,88)', 'rgb(28,131,79)', 'rgb(29,178,103)', 'rgb(30,209,116)', 'rgb(55,100,75)', 'rgb(60,160,105)', 'rgb(70,215,140)', 'rgb(80,255,175)', 'rgb(65,180,120)', 'rgb(60,165,110)', 'rgb(65,210,135)', 'rgb(70,240,150)']
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

echo "✓ Installed theme: Retro Green"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Retro Green' profile"
