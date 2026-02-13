#!/bin/bash
# GNOME Terminal Theme: UNSC Command
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="UNSC Command"
PROFILE_SLUG="unsc-command"
PROFILE_UUID="223a5cf6-95f3-42f9-bc31-12e3d956f3ce"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='UNSC Command'
background-color='rgb(11,22,32)'
foreground-color='rgb(220,231,242)'
palette=['rgb(11,22,32)', 'rgb(201,74,74)', 'rgb(76,175,80)', 'rgb(214,182,92)', 'rgb(77,166,255)', 'rgb(140,111,209)', 'rgb(79,179,179)', 'rgb(220,231,242)', 'rgb(75,95,115)', 'rgb(229,115,115)', 'rgb(129,199,132)', 'rgb(255,213,79)', 'rgb(130,184,255)', 'rgb(179,157,219)', 'rgb(128,222,234)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: UNSC Command"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'UNSC Command' profile"
