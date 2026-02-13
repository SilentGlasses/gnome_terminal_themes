#!/bin/bash
# GNOME Terminal Theme: Kasumi Night
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Kasumi Night"
PROFILE_SLUG="kasumi-night"
PROFILE_UUID="a654fd23-fb12-4e89-ab59-b5bba3fb1a27"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Kasumi Night'
background-color='rgb(18,22,23)'
foreground-color='rgb(214,218,215)'
palette=['rgb(18,22,23)', 'rgb(143,62,62)', 'rgb(95,124,116)', 'rgb(154,138,74)', 'rgb(63,98,114)', 'rgb(107,90,122)', 'rgb(95,138,138)', 'rgb(207,212,209)', 'rgb(85,95,98)', 'rgb(179,90,90)', 'rgb(127,165,155)', 'rgb(196,179,106)', 'rgb(95,138,163)', 'rgb(144,115,173)', 'rgb(127,191,184)', 'rgb(242,244,243)']
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

echo "✓ Installed theme: Kasumi Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Kasumi Night' profile"
