#!/bin/bash
# GNOME Terminal Theme: Ethereal Galaxy Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ethereal Galaxy Dark"
PROFILE_SLUG="ethereal-galaxy-dark"
PROFILE_UUID="d21ec6a1-7c46-41d5-87b0-ad645f9cba99"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ethereal Galaxy Dark'
background-color='rgb(28,28,63)'
foreground-color='rgb(220,220,224)'
palette=['rgb(28,28,63)', 'rgb(191,101,240)', 'rgb(164,204,53)', 'rgb(255,210,74)', 'rgb(245,83,191)', 'rgb(242,129,68)', 'rgb(38,201,158)', 'rgb(193,193,201)', 'rgb(55,55,86)', 'rgb(102,191,255)', 'rgb(38,201,158)', 'rgb(255,210,74)', 'rgb(245,83,191)', 'rgb(242,129,68)', 'rgb(38,201,158)', 'rgb(220,220,224)']
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

echo "✓ Installed theme: Ethereal Galaxy Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ethereal Galaxy Dark' profile"
