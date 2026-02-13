#!/bin/bash
# GNOME Terminal Theme: African History
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="African History"
PROFILE_SLUG="african-history"
PROFILE_UUID="ed9771d7-6b2c-4dc5-b075-153657452fac"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='African History'
background-color='rgb(32,28,29)'
foreground-color='rgb(220,195,175)'
palette=['rgb(50,45,42)', 'rgb(215,110,90)', 'rgb(95,165,120)', 'rgb(240,205,70)', 'rgb(85,140,190)', 'rgb(140,120,170)', 'rgb(115,170,170)', 'rgb(245,240,235)', 'rgb(80,72,68)', 'rgb(235,135,115)', 'rgb(125,190,145)', 'rgb(250,220,100)', 'rgb(120,170,215)', 'rgb(175,155,200)', 'rgb(150,200,200)', 'rgb(255,250,245)']
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

echo "✓ Installed theme: African History"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'African History' profile"
