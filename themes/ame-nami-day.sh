#!/bin/bash
# GNOME Terminal Theme: Ame-Nami Day
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ame-Nami Day"
PROFILE_SLUG="ame-nami-day"
PROFILE_UUID="2a9e5fcd-a51a-4eec-bf05-5fbeae7a9d59"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ame-Nami Day'
background-color='rgb(238,244,245)'
foreground-color='rgb(36,50,54)'
palette=['rgb(36,50,54)', 'rgb(168,74,74)', 'rgb(95,143,127)', 'rgb(191,163,95)', 'rgb(47,111,163)', 'rgb(127,95,159)', 'rgb(79,163,179)', 'rgb(228,237,237)', 'rgb(66,90,99)', 'rgb(204,106,106)', 'rgb(127,179,163)', 'rgb(224,201,138)', 'rgb(95,167,224)', 'rgb(168,143,212)', 'rgb(127,212,224)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Ame-Nami Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ame-Nami Day' profile"
