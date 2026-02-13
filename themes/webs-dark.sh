#!/bin/bash
# GNOME Terminal Theme: Webs Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Webs Dark"
PROFILE_SLUG="webs-dark"
PROFILE_UUID="2ab3c10e-d4b0-47a6-bb0b-1d013b07bb3f"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Webs Dark'
background-color='rgb(25,28,32)'
foreground-color='rgb(200,205,215)'
palette=['rgb(40,45,52)', 'rgb(200,95,95)', 'rgb(85,160,90)', 'rgb(205,210,105)', 'rgb(125,140,210)', 'rgb(175,95,245)', 'rgb(145,180,200)', 'rgb(228,230,235)', 'rgb(65,72,82)', 'rgb(230,125,125)', 'rgb(115,190,120)', 'rgb(230,235,135)', 'rgb(155,170,235)', 'rgb(205,135,255)', 'rgb(175,210,230)', 'rgb(242,244,248)']
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

echo "✓ Installed theme: Webs Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Webs Dark' profile"
