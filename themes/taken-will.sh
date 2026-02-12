#!/bin/bash
# GNOME Terminal Theme: Taken Will
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Taken Will"
PROFILE_SLUG="taken-will"
PROFILE_UUID="be98d163-de16-4d37-991e-5b50f2a6d0a2"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Taken Will'
background-color='rgb(34,36,51)'
foreground-color='rgb(215,239,247)'
palette=['rgb(6,12,20)', 'rgb(48,63,79)', 'rgb(85,118,125)', 'rgb(131,151,160)', 'rgb(43,70,83)', 'rgb(72,82,93)', 'rgb(178,200,209)', 'rgb(231,249,255)', 'rgb(6,12,20)', 'rgb(48,63,79)', 'rgb(85,118,125)', 'rgb(131,151,160)', 'rgb(43,70,83)', 'rgb(72,82,93)', 'rgb(178,200,209)', 'rgb(231,249,255)']
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

echo "✓ Installed theme: Taken Will"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Taken Will' profile"
