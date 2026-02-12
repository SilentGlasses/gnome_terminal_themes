#!/bin/bash
# GNOME Terminal Theme: Liquid Glass Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Liquid Glass Dark"
PROFILE_SLUG="liquid-glass-dark"
PROFILE_UUID="223eb082-d75d-40bd-b1f6-cc9d315e9c02"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Liquid Glass Dark'
background-color='rgb(15,17,26)'
foreground-color='rgb(229,233,240)'
palette=['rgb(26,28,36)', 'rgb(255,69,58)', 'rgb(50,215,75)', 'rgb(255,214,10)', 'rgb(10,132,255)', 'rgb(191,90,242)', 'rgb(100,210,255)', 'rgb(208,211,220)', 'rgb(44,47,58)', 'rgb(255,107,97)', 'rgb(92,217,122)', 'rgb(255,224,85)', 'rgb(64,156,255)', 'rgb(221,166,255)', 'rgb(139,234,255)', 'rgb(245,247,250)']
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

echo "✓ Installed theme: Liquid Glass Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Liquid Glass Dark' profile"
