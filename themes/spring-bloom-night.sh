#!/bin/bash
# GNOME Terminal Theme: Spring Bloom Night
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Spring Bloom Night"
PROFILE_SLUG="spring-bloom-night"
PROFILE_UUID="2c677aa6-ff20-45f8-9236-bfd001cba511"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Spring Bloom Night'
background-color='rgb(15,26,20)'
foreground-color='rgb(234,246,238)'
palette=['rgb(15,26,20)', 'rgb(217,108,123)', 'rgb(111,191,143)', 'rgb(217,199,122)', 'rgb(127,182,217)', 'rgb(194,143,217)', 'rgb(111,208,200)', 'rgb(219,238,226)', 'rgb(34,56,44)', 'rgb(240,138,150)', 'rgb(143,221,176)', 'rgb(240,225,154)', 'rgb(159,208,240)', 'rgb(221,176,240)', 'rgb(143,240,230)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Spring Bloom Night"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Spring Bloom Night' profile"
