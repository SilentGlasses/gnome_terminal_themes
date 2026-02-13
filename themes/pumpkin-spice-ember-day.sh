#!/bin/bash
# GNOME Terminal Theme: Pumpkin Spice Ember Day
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Pumpkin Spice Ember Day"
PROFILE_SLUG="pumpkin-spice-ember-day"
PROFILE_UUID="ddac71f8-f920-427b-badb-1294d9d5f521"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Pumpkin Spice Ember Day'
background-color='rgb(248,239,230)'
foreground-color='rgb(59,31,18)'
palette=['rgb(59,31,18)', 'rgb(169,68,28)', 'rgb(138,74,36)', 'rgb(196,104,46)', 'rgb(159,90,46)', 'rgb(122,63,32)', 'rgb(207,122,58)', 'rgb(242,228,216)', 'rgb(106,58,34)', 'rgb(208,96,52)', 'rgb(179,106,58)', 'rgb(255,159,74)', 'rgb(201,122,70)', 'rgb(168,90,48)', 'rgb(255,184,120)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Pumpkin Spice Ember Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Pumpkin Spice Ember Day' profile"
