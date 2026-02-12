#!/bin/bash
# GNOME Terminal Theme: Dark Knight
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Dark Knight"
PROFILE_SLUG="dark-knight"
PROFILE_UUID="93b2c01c-48e4-498a-9f08-86c119ca8c3a"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Dark Knight'
background-color='rgb(12,16,20)'
foreground-color='rgb(153,209,206)'
palette=['rgb(9,31,46)', 'rgb(194,49,39)', 'rgb(42,168,137)', 'rgb(237,180,67)', 'rgb(30,100,121)', 'rgb(136,140,166)', 'rgb(51,133,158)', 'rgb(211,235,233)', 'rgb(9,31,46)', 'rgb(194,49,39)', 'rgb(42,168,137)', 'rgb(237,180,67)', 'rgb(30,100,121)', 'rgb(136,140,166)', 'rgb(51,133,158)', 'rgb(211,235,233)']
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

echo "✓ Installed theme: Dark Knight"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Dark Knight' profile"
