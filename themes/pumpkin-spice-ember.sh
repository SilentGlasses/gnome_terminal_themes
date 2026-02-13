#!/bin/bash
# GNOME Terminal Theme: Pumpkin Spice Ember
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Pumpkin Spice Ember"
PROFILE_SLUG="pumpkin-spice-ember"
PROFILE_UUID="ce6f758b-97a7-4c37-9fd0-91ce525fa65c"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Pumpkin Spice Ember'
background-color='rgb(27,15,8)'
foreground-color='rgb(246,239,232)'
palette=['rgb(27,15,8)', 'rgb(179,71,30)', 'rgb(143,74,34)', 'rgb(201,106,44)', 'rgb(163,86,42)', 'rgb(122,58,28)', 'rgb(212,122,58)', 'rgb(226,207,192)', 'rgb(115,85,65)', 'rgb(224,96,44)', 'rgb(179,95,47)', 'rgb(255,154,60)', 'rgb(196,106,52)', 'rgb(162,79,38)', 'rgb(255,176,106)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Pumpkin Spice Ember"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Pumpkin Spice Ember' profile"
