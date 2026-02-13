#!/bin/bash
# GNOME Terminal Theme: Strand Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Strand Dark"
PROFILE_SLUG="strand-dark"
PROFILE_UUID="f87300a6-d345-4add-996c-dea316a17d13"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Strand Dark'
background-color='rgb(10,18,15)'
foreground-color='rgb(180,235,199)'
palette=['rgb(10,18,15)', 'rgb(255,101,122)', 'rgb(0,255,159)', 'rgb(235,255,31)', 'rgb(0,199,235)', 'rgb(199,0,235)', 'rgb(0,235,199)', 'rgb(180,235,199)', 'rgb(70,95,80)', 'rgb(255,133,154)', 'rgb(32,255,175)', 'rgb(235,255,63)', 'rgb(32,215,251)', 'rgb(215,16,251)', 'rgb(32,251,215)', 'rgb(212,251,231)']
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

echo "✓ Installed theme: Strand Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Strand Dark' profile"
