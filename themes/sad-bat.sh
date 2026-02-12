#!/bin/bash
# GNOME Terminal Theme: Sad Bat
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Sad Bat"
PROFILE_SLUG="sad-bat"
PROFILE_UUID="77e8eb8e-18e0-46f1-93e7-d12d03582706"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Sad Bat'
background-color='rgb(42,44,46)'
foreground-color='rgb(74,85,117)'
palette=['rgb(25,25,25)', 'rgb(148,65,65)', 'rgb(55,112,58)', 'rgb(171,176,74)', 'rgb(88,101,173)', 'rgb(138,43,226)', 'rgb(147,172,191)', 'rgb(223,224,229)', 'rgb(25,25,25)', 'rgb(148,65,65)', 'rgb(55,112,58)', 'rgb(171,176,74)', 'rgb(88,101,173)', 'rgb(138,43,226)', 'rgb(147,172,191)', 'rgb(223,224,229)']
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

echo "✓ Installed theme: Sad Bat"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Sad Bat' profile"
