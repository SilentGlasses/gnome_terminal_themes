#!/bin/bash
# GNOME Terminal Theme: White Rabbit Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="White Rabbit Dark"
PROFILE_SLUG="white-rabbit-dark"
PROFILE_UUID="9bc27247-d2ef-473f-8382-de0152522258"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='White Rabbit Dark'
background-color='rgb(8,12,10)'
foreground-color='rgb(200,245,220)'
palette=['rgb(20,35,25)', 'rgb(255,100,100)', 'rgb(80,220,120)', 'rgb(240,230,100)', 'rgb(100,180,255)', 'rgb(200,140,255)', 'rgb(100,230,200)', 'rgb(220,250,235)', 'rgb(45,65,55)', 'rgb(255,140,140)', 'rgb(120,245,155)', 'rgb(255,245,140)', 'rgb(140,210,255)', 'rgb(225,175,255)', 'rgb(140,250,225)', 'rgb(240,255,248)']
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

echo "✓ Installed theme: White Rabbit Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'White Rabbit Dark' profile"
