#!/bin/bash
# GNOME Terminal Theme: Solar Tide Night
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Solar Tide Night"
PROFILE_SLUG="solar-tide-night"
PROFILE_UUID="3545fb22-89a9-4842-8cb5-77404540d746"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Solar Tide Night'
background-color='rgb(14,26,34)'
foreground-color='rgb(238,246,251)'
palette=['rgb(14,26,34)', 'rgb(255,122,92)', 'rgb(127,209,161)', 'rgb(255,209,102)', 'rgb(95,168,211)', 'rgb(195,139,214)', 'rgb(95,211,198)', 'rgb(220,234,242)', 'rgb(80,105,125)', 'rgb(255,154,130)', 'rgb(159,230,187)', 'rgb(255,224,138)', 'rgb(127,194,232)', 'rgb(221,179,239)', 'rgb(127,240,224)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Solar Tide Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Solar Tide Night' profile"
