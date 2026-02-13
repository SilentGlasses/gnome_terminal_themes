#!/bin/bash
# GNOME Terminal Theme: Flood Contagion
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Flood Contagion"
PROFILE_SLUG="flood-contagion"
PROFILE_UUID="3f71c424-e151-4bfe-8c71-2ec8feefaefa"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Flood Contagion'
background-color='rgb(20,17,14)'
foreground-color='rgb(230,225,214)'
palette=['rgb(20,17,14)', 'rgb(124,47,42)', 'rgb(110,127,74)', 'rgb(154,138,74)', 'rgb(74,107,112)', 'rgb(106,74,94)', 'rgb(94,127,130)', 'rgb(230,225,214)', 'rgb(100,92,80)', 'rgb(168,71,64)', 'rgb(143,160,94)', 'rgb(194,182,106)', 'rgb(111,163,166)', 'rgb(140,106,130)', 'rgb(143,183,186)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Flood Contagion"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Flood Contagion' profile"
