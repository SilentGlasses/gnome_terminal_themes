#!/bin/bash
# GNOME Terminal Theme: Kasumi Day
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Kasumi Day"
PROFILE_SLUG="kasumi-day"
PROFILE_UUID="67ed5cb0-233d-4552-8916-290e37216df5"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Kasumi Day'
background-color='rgb(242,244,241)'
foreground-color='rgb(45,52,52)'
palette=['rgb(45,52,52)', 'rgb(154,74,74)', 'rgb(111,143,135)', 'rgb(179,163,95)', 'rgb(79,115,138)', 'rgb(122,104,143)', 'rgb(111,154,154)', 'rgb(230,233,229)', 'rgb(74,84,84)', 'rgb(192,106,106)', 'rgb(143,179,170)', 'rgb(212,197,127)', 'rgb(111,159,194)', 'rgb(164,139,194)', 'rgb(143,207,199)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Kasumi Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Kasumi Day' profile"
