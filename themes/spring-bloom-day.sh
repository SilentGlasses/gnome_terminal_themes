#!/bin/bash
# GNOME Terminal Theme: Spring Bloom Day
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Spring Bloom Day"
PROFILE_SLUG="spring-bloom-day"
PROFILE_UUID="408cbeff-ac43-4a57-9cc2-c5d5be04bf4d"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Spring Bloom Day'
background-color='rgb(241,250,244)'
foreground-color='rgb(32,56,42)'
palette=['rgb(32,56,42)', 'rgb(200,95,111)', 'rgb(95,168,122)', 'rgb(201,184,95)', 'rgb(111,167,201)', 'rgb(176,127,201)', 'rgb(95,191,182)', 'rgb(232,245,238)', 'rgb(74,106,90)', 'rgb(224,127,143)', 'rgb(127,201,154)', 'rgb(230,217,127)', 'rgb(143,195,230)', 'rgb(207,167,230)', 'rgb(127,224,214)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Spring Bloom Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Spring Bloom Day' profile"
