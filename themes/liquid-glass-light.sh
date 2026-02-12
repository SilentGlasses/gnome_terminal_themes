#!/bin/bash
# GNOME Terminal Theme: Liquid Glass Light
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Liquid Glass Light"
PROFILE_SLUG="liquid-glass-light"
PROFILE_UUID="196f90b0-6ef8-4b1f-ab5e-d05048f38844"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Liquid Glass Light'
background-color='rgb(255,255,255)'
foreground-color='rgb(28,30,33)'
palette=['rgb(0,0,0)', 'rgb(153,1,0)', 'rgb(0,166,0)', 'rgb(153,153,0)', 'rgb(2,0,178)', 'rgb(178,0,178)', 'rgb(0,166,178)', 'rgb(244,248,240)', 'rgb(102,102,102)', 'rgb(230,3,0)', 'rgb(0,217,0)', 'rgb(230,229,0)', 'rgb(6,0,255)', 'rgb(230,0,230)', 'rgb(0,230,230)', 'rgb(244,248,240)']
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

echo "✓ Installed theme: Liquid Glass Light"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Liquid Glass Light' profile"
