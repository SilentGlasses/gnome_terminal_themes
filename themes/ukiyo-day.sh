#!/bin/bash
# GNOME Terminal Theme: Ukiyo Day
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ukiyo Day"
PROFILE_SLUG="ukiyo-day"
PROFILE_UUID="2ee49736-e2f0-4a3f-be7e-6d3c2473e0f9"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ukiyo Day'
background-color='rgb(244,241,234)'
foreground-color='rgb(42,47,46)'
palette=['rgb(42,47,46)', 'rgb(162,67,61)', 'rgb(107,143,113)', 'rgb(184,155,74)', 'rgb(58,111,143)', 'rgb(123,90,143)', 'rgb(95,143,138)', 'rgb(232,229,220)', 'rgb(74,80,78)', 'rgb(192,90,82)', 'rgb(137,179,154)', 'rgb(217,195,122)', 'rgb(95,147,184)', 'rgb(164,127,194)', 'rgb(127,194,187)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Ukiyo Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ukiyo Day' profile"
