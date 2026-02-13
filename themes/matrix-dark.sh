#!/bin/bash
# GNOME Terminal Theme: Matrix Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Matrix Dark"
PROFILE_SLUG="matrix-dark"
PROFILE_UUID="c249bd2b-e2e1-45f7-89ee-98c213890c6b"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Matrix Dark'
background-color='rgb(15,25,28)'
foreground-color='rgb(193,255,138)'
palette=['rgb(15,25,28)', 'rgb(35,117,90)', 'rgb(130,217,103)', 'rgb(255,215,0)', 'rgb(63,82,66)', 'rgb(64,153,49)', 'rgb(80,180,90)', 'rgb(193,255,138)', 'rgb(60,95,75)', 'rgb(70,150,115)', 'rgb(160,235,130)', 'rgb(255,225,60)', 'rgb(95,120,100)', 'rgb(100,185,80)', 'rgb(115,210,125)', 'rgb(220,255,175)']
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

echo "✓ Installed theme: Matrix Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Matrix Dark' profile"
