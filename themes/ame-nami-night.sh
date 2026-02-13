#!/bin/bash
# GNOME Terminal Theme: Ame-Nami Night
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ame-Nami Night"
PROFILE_SLUG="ame-nami-night"
PROFILE_UUID="750e869b-1ed6-4ca5-a691-6b76ab157394"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ame-Nami Night'
background-color='rgb(12,20,24)'
foreground-color='rgb(219,228,225)'
palette=['rgb(12,20,24)', 'rgb(161,63,63)', 'rgb(79,127,111)', 'rgb(179,143,63)', 'rgb(31,95,143)', 'rgb(111,79,127)', 'rgb(63,143,159)', 'rgb(207,218,215)', 'rgb(85,100,110)', 'rgb(199,90,90)', 'rgb(111,165,154)', 'rgb(214,185,106)', 'rgb(79,147,199)', 'rgb(159,115,191)', 'rgb(111,199,211)', 'rgb(243,247,246)']
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

echo "✓ Installed theme: Ame-Nami Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ame-Nami Night' profile"
