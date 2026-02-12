#!/bin/bash
# GNOME Terminal Theme: Frostbound Night
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Frostbound Night"
PROFILE_SLUG="frostbound-night"
PROFILE_UUID="88799dcb-629b-4519-87ed-fc9fcc2ab589"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Frostbound Night'
background-color='rgb(11,17,22)'
foreground-color='rgb(238,244,249)'
palette=['rgb(11,17,22)', 'rgb(196,106,106)', 'rgb(127,179,163)', 'rgb(201,184,127)', 'rgb(111,167,217)', 'rgb(168,143,212)', 'rgb(127,207,217)', 'rgb(220,230,238)', 'rgb(26,39,50)', 'rgb(224,138,138)', 'rgb(159,208,192)', 'rgb(230,215,159)', 'rgb(143,195,240)', 'rgb(192,167,230)', 'rgb(159,230,240)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Frostbound Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Frostbound Night' profile"
