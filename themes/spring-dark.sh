#!/bin/bash
# GNOME Terminal Theme: Spring Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Spring Dark"
PROFILE_SLUG="spring-dark"
PROFILE_UUID="6684c3e9-938f-4fc8-8cba-ed77b626f664"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Spring Dark'
background-color='rgb(54,54,54)'
foreground-color='rgb(210,215,211)'
palette=['rgb(43,43,43)', 'rgb(250,167,166)', 'rgb(152,251,152)', 'rgb(255,250,205)', 'rgb(175,238,238)', 'rgb(255,182,193)', 'rgb(224,255,255)', 'rgb(253,254,254)', 'rgb(43,43,43)', 'rgb(250,167,166)', 'rgb(152,251,152)', 'rgb(255,250,205)', 'rgb(175,238,238)', 'rgb(255,182,193)', 'rgb(224,255,255)', 'rgb(253,254,254)']
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

echo "✓ Installed theme: Spring Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Spring Dark' profile"
