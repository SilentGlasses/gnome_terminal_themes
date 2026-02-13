#!/bin/bash
# GNOME Terminal Theme: Material Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Material Dark"
PROFILE_SLUG="material-dark"
PROFILE_UUID="483111d3-0646-435e-be8c-4928073f88ab"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Material Dark'
background-color='rgb(34,44,50)'
foreground-color='rgb(250,254,254)'
palette=['rgb(73,100,111)', 'rgb(253,128,117)', 'rgb(176,246,195)', 'rgb(251,223,116)', 'rgb(116,211,247)', 'rgb(252,115,161)', 'rgb(155,252,228)', 'rgb(250,254,254)', 'rgb(73,100,111)', 'rgb(253,128,117)', 'rgb(176,246,195)', 'rgb(251,223,116)', 'rgb(116,211,247)', 'rgb(252,115,161)', 'rgb(155,252,228)', 'rgb(250,254,254)']
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

echo "✓ Installed theme: Material Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Material Dark' profile"
