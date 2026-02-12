#!/bin/bash
# GNOME Terminal Theme: LLM Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="LLM Dark"
PROFILE_SLUG="llm-dark"
PROFILE_UUID="68fc9c39-e888-4479-bf00-68136f828bea"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='LLM Dark'
background-color='rgb(20,35,56)'
foreground-color='rgb(254,254,254)'
palette=['rgb(0,0,0)', 'rgb(234,94,57)', 'rgb(127,155,123)', 'rgb(244,191,97)', 'rgb(142,154,246)', 'rgb(236,143,249)', 'rgb(180,209,251)', 'rgb(254,254,254)', 'rgb(90,105,130)', 'rgb(234,94,57)', 'rgb(127,155,123)', 'rgb(244,191,97)', 'rgb(142,154,246)', 'rgb(236,143,249)', 'rgb(180,209,251)', 'rgb(254,254,254)']
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

echo "✓ Installed theme: LLM Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'LLM Dark' profile"
