#!/bin/bash
# GNOME Terminal Theme: Kali Blue
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Kali Blue"
PROFILE_SLUG="kali-blue"
PROFILE_UUID="b3ef7752-439a-4b65-8e52-db9097cf118f"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Kali Blue'
background-color='rgb(21,28,36)'
foreground-color='rgb(146,211,216)'
palette=['rgb(1,3,5)', 'rgb(87,94,97)', 'rgb(37,113,140)', 'rgb(98,124,133)', 'rgb(42,133,154)', 'rgb(46,147,169)', 'rgb(51,169,184)', 'rgb(146,211,216)', 'rgb(1,3,5)', 'rgb(87,94,97)', 'rgb(37,113,140)', 'rgb(98,124,133)', 'rgb(42,133,154)', 'rgb(46,147,169)', 'rgb(51,169,184)', 'rgb(146,211,216)']
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

echo "✓ Installed theme: Kali Blue"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Kali Blue' profile"
