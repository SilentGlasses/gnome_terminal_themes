#!/bin/bash
# GNOME Terminal Theme: Ukiyo Night
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Ukiyo Night"
PROFILE_SLUG="ukiyo-night"
PROFILE_UUID="3298a93f-8553-4dcf-9afb-d2d554a0759e"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Ukiyo Night'
background-color='rgb(15,27,30)'
foreground-color='rgb(216,225,220)'
palette=['rgb(15,27,30)', 'rgb(158,61,63)', 'rgb(95,127,106)', 'rgb(176,138,62)', 'rgb(47,93,115)', 'rgb(110,79,121)', 'rgb(79,127,122)', 'rgb(207,216,211)', 'rgb(80,100,105)', 'rgb(197,84,84)', 'rgb(127,163,138)', 'rgb(214,180,92)', 'rgb(79,134,161)', 'rgb(154,111,176)', 'rgb(111,177,170)', 'rgb(241,245,243)']
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

echo "✓ Installed theme: Ukiyo Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Ukiyo Night' profile"
