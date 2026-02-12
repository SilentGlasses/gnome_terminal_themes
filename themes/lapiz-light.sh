#!/bin/bash
# GNOME Terminal Theme: Lapiz Light
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Lapiz Light"
PROFILE_SLUG="lapiz-light"
PROFILE_UUID="d97b9f11-a420-4b27-b529-357516c309dc"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Lapiz Light'
background-color='rgb(241,241,241)'
foreground-color='rgb(66,66,66)'
palette=['rgb(33,33,33)', 'rgb(195,7,113)', 'rgb(16,167,120)', 'rgb(168,156,20)', 'rgb(0,142,196)', 'rgb(82,60,121)', 'rgb(32,165,186)', 'rgb(224,224,224)', 'rgb(33,33,33)', 'rgb(251,0,122)', 'rgb(95,215,175)', 'rgb(243,228,48)', 'rgb(32,187,252)', 'rgb(104,85,222)', 'rgb(79,184,204)', 'rgb(241,241,241)']
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

echo "✓ Installed theme: Lapiz Light"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Lapiz Light' profile"
