#!/bin/bash
# GNOME Terminal Theme: Mjolnir Warp
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Mjolnir Warp"
PROFILE_SLUG="mjolnir-warp"
PROFILE_UUID="dd27018d-8391-4003-806d-fd3e79b8d72d"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Mjolnir Warp'
background-color='rgb(44,46,42)'
foreground-color='rgb(205,207,204)'
palette=['rgb(13,9,13)', 'rgb(132,61,62)', 'rgb(132,146,106)', 'rgb(239,184,42)', 'rgb(110,146,200)', 'rgb(119,107,167)', 'rgb(151,223,225)', 'rgb(205,207,204)', 'rgb(100,100,95)', 'rgb(165,95,95)', 'rgb(160,175,135)', 'rgb(250,205,80)', 'rgb(140,175,225)', 'rgb(150,140,195)', 'rgb(180,240,242)', 'rgb(230,232,230)']
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

echo "✓ Installed theme: Mjolnir Warp"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Mjolnir Warp' profile"
