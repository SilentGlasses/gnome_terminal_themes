#!/bin/bash
# GNOME Terminal Theme: Neon Nights
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Neon Nights"
PROFILE_SLUG="neon-nights"
PROFILE_UUID="201b1742-9305-4f56-8b3d-10dbc30f1d86"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Neon Nights'
background-color='rgb(35,31,32)'
foreground-color='rgb(229,233,240)'
palette=['rgb(28,11,29)', 'rgb(234,0,20)', 'rgb(0,237,4)', 'rgb(242,242,0)', 'rgb(0,181,236)', 'rgb(244,0,244)', 'rgb(0,225,241)', 'rgb(238,238,238)', 'rgb(100,85,100)', 'rgb(255,0,77)', 'rgb(0,255,13)', 'rgb(241,255,0)', 'rgb(0,200,255)', 'rgb(255,0,251)', 'rgb(0,247,255)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Neon Nights"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Neon Nights' profile"
