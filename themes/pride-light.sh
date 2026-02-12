#!/bin/bash
# GNOME Terminal Theme: Pride Light
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Pride Light"
PROFILE_SLUG="pride-light"
PROFILE_UUID="689c9a19-a73f-4522-b539-50b348ca6fc4"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Pride Light'
background-color='rgb(255,245,245)'
foreground-color='rgb(111,59,108)'
palette=['rgb(53,33,22)', 'rgb(243,67,67)', 'rgb(23,195,75)', 'rgb(188,180,0)', 'rgb(103,103,255)', 'rgb(211,99,211)', 'rgb(118,237,237)', 'rgb(255,251,251)', 'rgb(89,54,36)', 'rgb(255,75,75)', 'rgb(28,219,85)', 'rgb(216,206,5)', 'rgb(128,128,252)', 'rgb(230,115,230)', 'rgb(136,255,255)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Pride Light"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Pride Light' profile"
