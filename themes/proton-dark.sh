#!/bin/bash
# GNOME Terminal Theme: Proton Dark
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Proton Dark"
PROFILE_SLUG="proton-dark"
PROFILE_UUID="aa1ed7eb-0ed1-4c4f-9381-eadfde51c0b0"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Proton Dark'
background-color='rgb(27,19,64)'
foreground-color='rgb(245,244,242)'
palette=['rgb(27,19,64)', 'rgb(235,80,141)', 'rgb(102,222,177)', 'rgb(249,217,73)', 'rgb(80,176,233)', 'rgb(109,74,246)', 'rgb(196,183,255)', 'rgb(245,244,242)', 'rgb(90,80,130)', 'rgb(250,115,170)', 'rgb(135,240,200)', 'rgb(255,230,110)', 'rgb(115,200,250)', 'rgb(145,115,255)', 'rgb(215,205,255)', 'rgb(255,254,252)']
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

echo "✓ Installed theme: Proton Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Proton Dark' profile"
