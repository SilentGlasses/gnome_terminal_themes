#!/bin/bash
# GNOME Terminal Theme: Solar Tide Day
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Solar Tide Day"
PROFILE_SLUG="solar-tide-day"
PROFILE_UUID="ececa97e-1631-449e-8624-bc5b914db33a"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Solar Tide Day'
background-color='rgb(245,251,255)'
foreground-color='rgb(31,52,66)'
palette=['rgb(31,52,66)', 'rgb(232,106,79)', 'rgb(111,191,147)', 'rgb(230,184,79)', 'rgb(95,159,201)', 'rgb(176,127,201)', 'rgb(95,191,182)', 'rgb(238,246,251)', 'rgb(79,106,122)', 'rgb(255,138,111)', 'rgb(143,217,174)', 'rgb(255,217,127)', 'rgb(143,195,230)', 'rgb(207,167,230)', 'rgb(127,224,214)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Solar Tide Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Solar Tide Day' profile"
