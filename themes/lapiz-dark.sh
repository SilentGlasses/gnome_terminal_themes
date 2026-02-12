#!/bin/bash
# GNOME Terminal Theme: Lapiz Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Lapiz Dark"
PROFILE_SLUG="lapiz-dark"
PROFILE_UUID="de8af416-1f20-4803-893f-7363155fd75c"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Lapiz Dark'
background-color='rgb(48,48,48)'
foreground-color='rgb(241,241,241)'
palette=['rgb(48,48,48)', 'rgb(178,82,130)', 'rgb(126,175,141)', 'rgb(238,227,89)', 'rgb(110,158,203)', 'rgb(97,84,136)', 'rgb(124,176,195)', 'rgb(243,243,241)', 'rgb(115,115,115)', 'rgb(200,110,155)', 'rgb(155,200,170)', 'rgb(250,240,120)', 'rgb(140,185,225)', 'rgb(130,115,170)', 'rgb(155,200,220)', 'rgb(255,255,253)']
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

echo "✓ Installed theme: Lapiz Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Lapiz Dark' profile"
