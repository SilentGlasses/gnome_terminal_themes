#!/bin/bash
# GNOME Terminal Theme: Vintage Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Vintage Dark"
PROFILE_SLUG="vintage-dark"
PROFILE_UUID="7779e358-cea7-4221-8834-585eb66d5022"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Vintage Dark'
background-color='rgb(49,54,63)'
foreground-color='rgb(247,239,220)'
palette=['rgb(34,40,49)', 'rgb(255,148,138)', 'rgb(173,196,93)', 'rgb(237,211,100)', 'rgb(138,158,201)', 'rgb(215,160,214)', 'rgb(139,197,190)', 'rgb(247,239,220)', 'rgb(110,120,135)', 'rgb(255,175,165)', 'rgb(195,220,125)', 'rgb(250,230,135)', 'rgb(170,190,225)', 'rgb(235,190,235)', 'rgb(170,220,215)', 'rgb(255,250,235)']
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

echo "✓ Installed theme: Vintage Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Vintage Dark' profile"
