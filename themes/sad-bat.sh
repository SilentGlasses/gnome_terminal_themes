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
background-color='rgb(30,32,38)'
foreground-color='rgb(180,190,210)'
palette=['rgb(45,48,55)', 'rgb(200,100,100)', 'rgb(90,160,95)', 'rgb(210,215,110)', 'rgb(130,145,210)', 'rgb(180,100,240)', 'rgb(150,185,205)', 'rgb(230,232,238)', 'rgb(70,75,85)', 'rgb(230,130,130)', 'rgb(120,190,125)', 'rgb(235,240,140)', 'rgb(160,175,235)', 'rgb(210,140,255)', 'rgb(180,210,230)', 'rgb(245,247,252)']
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
