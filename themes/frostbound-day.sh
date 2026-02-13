#!/bin/bash
# GNOME Terminal Theme: Frostbound Day
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Frostbound Day"
PROFILE_SLUG="frostbound-day"
PROFILE_UUID="da739c84-5e4d-432e-9f0b-2f928e5295d0"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Frostbound Day'
background-color='rgb(243,247,251)'
foreground-color='rgb(26,39,50)'
palette=['rgb(26,39,50)', 'rgb(184,95,95)', 'rgb(111,168,154)', 'rgb(191,174,111)', 'rgb(95,147,191)', 'rgb(154,127,191)', 'rgb(111,191,201)', 'rgb(237,243,248)', 'rgb(74,102,122)', 'rgb(217,127,127)', 'rgb(143,201,187)', 'rgb(224,207,143)', 'rgb(127,179,224)', 'rgb(191,167,224)', 'rgb(143,218,230)', 'rgb(255,255,255)']
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

echo "✓ Installed theme: Frostbound Day"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Frostbound Day' profile"
