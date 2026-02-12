#!/bin/bash
# GNOME Terminal Theme: Tabs Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Tabs Dark"
PROFILE_SLUG="tabs-dark"
PROFILE_UUID="c7271ada-d119-40bb-b2e4-ea3022550636"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Tabs Dark'
background-color='rgb(42,42,42)'
foreground-color='rgb(254,254,254)'
palette=['rgb(0,0,0)', 'rgb(182,12,112)', 'rgb(23,162,120)', 'rgb(168,154,22)', 'rgb(6,138,187)', 'rgb(88,67,122)', 'rgb(70,157,175)', 'rgb(253,253,253)', 'rgb(105,105,105)', 'rgb(204,0,118)', 'rgb(16,165,121)', 'rgb(166,157,16)', 'rgb(0,142,195)', 'rgb(95,78,128)', 'rgb(26,167,180)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Tabs Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Tabs Dark' profile"
