#!/bin/bash
# GNOME Terminal Theme: Ride the Puppets Day
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ride the Puppets Day"
PROFILE_SLUG="ride-the-puppets-day"
PROFILE_UUID="5e3eb041-8a8b-405f-a6ec-9ad7d95cc498"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ride the Puppets Day'
background-color='rgb(230,234,239)'
foreground-color='rgb(30,36,43)'
palette=['rgb(30,36,43)', 'rgb(154,58,58)', 'rgb(95,143,127)', 'rgb(191,163,95)', 'rgb(47,111,163)', 'rgb(111,95,143)', 'rgb(79,147,163)', 'rgb(230,234,239)', 'rgb(74,85,99)', 'rgb(204,106,106)', 'rgb(127,179,163)', 'rgb(224,201,138)', 'rgb(95,167,224)', 'rgb(168,143,212)', 'rgb(127,212,224)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Ride the Puppets Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ride the Puppets Day' profile"
