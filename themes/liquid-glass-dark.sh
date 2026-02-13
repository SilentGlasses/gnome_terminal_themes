#!/bin/bash
# GNOME Terminal Theme: Liquid Glass Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Liquid Glass Dark"
PROFILE_SLUG="liquid-glass-dark"
PROFILE_UUID="223eb082-d75d-40bd-b1f6-cc9d315e9c02"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Liquid Glass Dark'
background-color='rgb(22,22,30)'
foreground-color='rgb(240,240,245)'
palette=['rgb(35,35,45)', 'rgb(255,105,97)', 'rgb(126,231,135)', 'rgb(255,212,96)', 'rgb(120,175,255)', 'rgb(210,160,255)', 'rgb(135,225,245)', 'rgb(220,220,230)', 'rgb(70,70,85)', 'rgb(255,140,130)', 'rgb(160,240,170)', 'rgb(255,228,140)', 'rgb(160,200,255)', 'rgb(230,190,255)', 'rgb(170,240,255)', 'rgb(250,250,255)']
use-theme-colors=false
use-theme-transparency=false
use-transparent-background=true
background-transparency-percent=15
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
