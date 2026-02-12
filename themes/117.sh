#!/bin/bash
# GNOME Terminal Theme: 117
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="117"
PROFILE_SLUG="117"
PROFILE_UUID="2a4e8d98-b4d3-4188-8f5b-f83e96cd6c8b"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='117'
background-color='rgb(22,22,22)'
foreground-color='rgb(249,252,240)'
palette=['rgb(27,18,26)', 'rgb(211,96,67)', 'rgb(153,158,94)', 'rgb(237,204,0)', 'rgb(100,124,186)', 'rgb(104,98,134)', 'rgb(186,198,236)', 'rgb(249,252,240)', 'rgb(95,85,92)', 'rgb(211,96,67)', 'rgb(153,158,94)', 'rgb(237,204,0)', 'rgb(100,124,186)', 'rgb(104,98,134)', 'rgb(186,198,236)', 'rgb(249,252,240)']
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

echo "✓ Installed theme: 117"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select '117' profile"
