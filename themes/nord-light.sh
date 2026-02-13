#!/bin/bash
# GNOME Terminal Theme: Nord Light
# For GNOME Terminal 3.52.0 (GNOME 46)

PROFILE_NAME="Nord Light"
PROFILE_SLUG="nord-light"
PROFILE_UUID="5b6abab7-4baf-417b-91fd-a3ca054770e3"

# Create new profile
dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ <<EOF
[/]
visible-name='Nord Light'
background-color='rgb(229,233,240)'
foreground-color='rgb(66,73,89)'
palette=['rgb(59,66,82)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(136,192,208)', 'rgb(216,222,233)', 'rgb(59,66,82)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(136,192,208)', 'rgb(216,222,233)']
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

echo "✓ Installed theme: Nord Light"
echo "  Profile UUID: $PROFILE_UUID"
echo "  To use: Open GNOME Terminal → Preferences → Select 'Nord Light' profile"
