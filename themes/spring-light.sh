#!/bin/bash
# GNOME Terminal Theme: Spring Light
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Spring Light"
PROFILE_SLUG="spring-light"
PROFILE_UUID="1a668192-0acd-4415-a7e6-f9bde64a1b70"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Spring Light'
background-color='rgb(255,255,255)'
foreground-color='rgb(52,73,94)'
palette=['rgb(112,112,112)', 'rgb(240,128,128)', 'rgb(130,224,170)', 'rgb(244,208,63)', 'rgb(133,193,233)', 'rgb(186,85,211)', 'rgb(175,238,238)', 'rgb(210,215,211)', 'rgb(112,112,112)', 'rgb(240,128,128)', 'rgb(130,224,170)', 'rgb(244,208,63)', 'rgb(133,193,233)', 'rgb(186,85,211)', 'rgb(175,238,238)', 'rgb(210,215,211)']
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

echo "✓ Installed theme: Spring Light"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Spring Light' profile"
