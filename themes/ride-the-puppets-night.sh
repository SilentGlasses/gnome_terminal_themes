#!/bin/bash
# GNOME Terminal Theme: Ride the Puppets Night
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ride the Puppets Night"
PROFILE_SLUG="ride-the-puppets-night"
PROFILE_UUID="b5a0ec9b-3fe7-499e-9003-b01fb8640b4d"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ride the Puppets Night'
background-color='rgb(11,13,16)'
foreground-color='rgb(216,219,224)'
palette=['rgb(11,13,16)', 'rgb(124,45,45)', 'rgb(79,111,95)', 'rgb(154,124,60)', 'rgb(47,111,163)', 'rgb(90,74,111)', 'rgb(63,143,163)', 'rgb(191,197,204)', 'rgb(85,95,105)', 'rgb(184,74,74)', 'rgb(111,163,143)', 'rgb(212,178,106)', 'rgb(95,167,224)', 'rgb(143,127,179)', 'rgb(127,212,224)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Ride the Puppets Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ride the Puppets Night' profile"
