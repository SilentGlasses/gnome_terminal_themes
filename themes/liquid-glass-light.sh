#!/bin/bash
# GNOME Terminal Theme: Liquid Glass Light
# Inspired by Apple's Liquid Glass design language
# Features: Frosted translucent feel, soft pastels, airy luminosity
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Liquid Glass Light"
PROFILE_SLUG="liquid-glass-light"
PROFILE_UUID="196f90b0-6ef8-4b1f-ab5e-d05048f38844"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Liquid Glass Light'
background-color='rgb(248,248,252)'
foreground-color='rgb(40,40,50)'
palette=['rgb(60,60,75)', 'rgb(215,75,70)', 'rgb(50,165,80)', 'rgb(185,140,30)', 'rgb(50,120,200)', 'rgb(160,90,180)', 'rgb(45,155,175)', 'rgb(130,130,145)', 'rgb(100,100,115)', 'rgb(235,100,95)', 'rgb(70,190,105)', 'rgb(210,165,50)', 'rgb(80,150,230)', 'rgb(190,120,210)', 'rgb(70,180,200)', 'rgb(180,180,195)']
use-theme-colors=false
use-theme-transparency=false
use-transparent-background=true
background-transparency-percent=12
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
