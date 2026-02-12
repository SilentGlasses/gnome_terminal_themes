#!/bin/bash
# GNOME Terminal Theme: White Rabbit Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="White Rabbit Dark"
PROFILE_SLUG="white-rabbit-dark"
PROFILE_UUID="9bc27247-d2ef-473f-8382-de0152522258"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='White Rabbit Dark'
background-color='rgb(0,0,0)'
foreground-color='rgb(143,215,185)'
palette=['rgb(0,26,14)', 'rgb(0,61,26)', 'rgb(0,95,15)', 'rgb(0,122,31)', 'rgb(0,143,17)', 'rgb(0,163,33)', 'rgb(0,183,51)', 'rgb(0,204,68)', 'rgb(0,230,77)', 'rgb(0,255,65)', 'rgb(51,255,51)', 'rgb(92,255,92)', 'rgb(127,255,127)', 'rgb(163,255,163)', 'rgb(204,255,204)', 'rgb(230,255,230)']
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

echo "✓ Installed theme: White Rabbit Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'White Rabbit Dark' profile"
