#!/bin/bash
# GNOME Terminal Theme: Covenant Glass Night
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Covenant Glass Night"
PROFILE_SLUG="covenant-glass-night"
PROFILE_UUID="645e2452-ec05-4cce-bbae-8791d058c4e4"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Covenant Glass Night'
background-color='rgb(9,11,16)'
foreground-color='rgb(228,232,240)'
palette=['rgb(9,11,16)', 'rgb(127,58,107)', 'rgb(58,107,143)', 'rgb(143,127,179)', 'rgb(79,120,212)', 'rgb(138,92,255)', 'rgb(95,191,255)', 'rgb(202,210,225)', 'rgb(90,95,115)', 'rgb(170,90,143)', 'rgb(95,143,191)', 'rgb(179,163,218)', 'rgb(111,153,232)', 'rgb(170,127,255)', 'rgb(127,212,255)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Covenant Glass Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Covenant Glass Night' profile"
