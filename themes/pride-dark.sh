#!/bin/bash
# GNOME Terminal Theme: Pride Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Pride Dark"
PROFILE_SLUG="pride-dark"
PROFILE_UUID="9b7ad272-3b2a-4ed9-b4d4-0625f449e00f"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Pride Dark'
background-color='rgb(35,31,31)'
foreground-color='rgb(255,168,197)'
palette=['rgb(123,77,51)', 'rgb(237,27,36)', 'rgb(35,177,77)', 'rgb(231,220,0)', 'rgb(22,23,255)', 'rgb(140,61,140)', 'rgb(109,218,218)', 'rgb(229,229,229)', 'rgb(123,77,51)', 'rgb(243,67,67)', 'rgb(23,195,75)', 'rgb(254,242,0)', 'rgb(67,67,255)', 'rgb(140,61,140)', 'rgb(118,237,237)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Pride Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Pride Dark' profile"
