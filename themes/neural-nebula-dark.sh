#!/bin/bash
# GNOME Terminal Theme: Neural Nebula Dark
# Converted from Warp theme
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Neural Nebula Dark"
PROFILE_SLUG="neural-nebula-dark"
PROFILE_UUID="02f7463c-4b51-4b1a-96bd-35b58d5b5cd1"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Neural Nebula Dark'
background-color='rgb(15,17,26)'
foreground-color='rgb(236,239,244)'
palette=['rgb(46,52,64)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(143,188,187)', 'rgb(216,222,233)', 'rgb(59,66,82)', 'rgb(208,135,112)', 'rgb(177,209,150)', 'rgb(240,211,153)', 'rgb(136,192,208)', 'rgb(214,180,225)', 'rgb(147,224,229)', 'rgb(236,239,244)']
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

echo "✓ Installed theme: Neural Nebula Dark"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Neural Nebula Dark' profile"
