#!/usr/bin/env bash

# Script to clean up invalid GNOME Terminal profile entries from the profile list

echo "GNOME Terminal Profile List Cleanup"
echo "===================================="
echo ""

# Check for dconf
if ! command -v dconf &> /dev/null; then
    echo "Error: dconf is required but not installed."
    exit 1
fi

# Get current profile list
PROFILE_LIST=$(dconf read /org/gnome/terminal/legacy/profiles:/list)

if [ -z "$PROFILE_LIST" ] || [ "$PROFILE_LIST" = "[]" ]; then
    echo "Profile list is empty. Nothing to clean."
    exit 0
fi

echo "Scanning profiles..."
echo ""

# Extract all profile IDs
PROFILES=$(echo "$PROFILE_LIST" | sed "s/\[//;s/\]//;s/'//g;s/, /\n/g")

# Check each profile and keep only valid ones
VALID_PROFILES=()
INVALID_COUNT=0

for profile in $PROFILES; do
    # Check if profile directory exists and has data
    if dconf list /org/gnome/terminal/legacy/profiles:/:$profile/ 2>/dev/null | grep -q "visible-name"; then
        profile_name=$(dconf read /org/gnome/terminal/legacy/profiles:/:$profile/visible-name 2>/dev/null)
        VALID_PROFILES+=("'$profile'")
        echo "✓ Valid: $profile_name ($profile)"
    else
        echo "✗ Invalid: $profile (no data)"
        ((INVALID_COUNT++))
    fi
done

echo ""
echo "Summary:"
echo "  Valid profiles: ${#VALID_PROFILES[@]}"
echo "  Invalid profiles: $INVALID_COUNT"
echo ""

if [ $INVALID_COUNT -eq 0 ]; then
    echo "No invalid profiles found. Nothing to clean."
    exit 0
fi

# Build new list
if [ ${#VALID_PROFILES[@]} -gt 0 ]; then
    NEW_LIST="[$(IFS=, ; echo "${VALID_PROFILES[*]}")]"
else
    NEW_LIST="[]"
fi

echo "Cleaning profile list..."
dconf write /org/gnome/terminal/legacy/profiles:/list "$NEW_LIST"
echo "✓ Profile list cleaned!"
echo ""
echo "Restart GNOME Terminal to see the changes."
