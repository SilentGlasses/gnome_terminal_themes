#!/usr/bin/env bash

# Ensure we're running with bash
if [[ -z "$BASH_VERSION" ]]; then
    echo "Error: This script requires bash."
    echo "Please run with: bash $0"
    exit 1
fi

# Clear screen at the start
printf "\033[2J\033[H"

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\n${BOLD}${RED}GNOME TERMINAL THEME UNINSTALLER${NC}"
echo -e "${BLUE}For GNOME Terminal 3.52.0 (GNOME 46)${NC}\n"

# Check for dconf dependency
if ! command -v dconf &> /dev/null; then
    echo -e "${RED}Error: dconf is required but not installed.${NC}"
    exit 1
fi

# Build list of installed themes from our scripts
declare -A themes
declare -A theme_uuids
index=1

for script in "$SCRIPT_DIR"/themes/*.sh; do
    
    # Extract theme name and UUID
    theme_name=$(grep "^PROFILE_NAME=" "$script" | cut -d'"' -f2)
    profile_uuid=$(grep "^PROFILE_UUID=" "$script" | cut -d'"' -f2)
    
    if [[ -n "$theme_name" ]] && [[ -n "$profile_uuid" ]]; then
        # Check if theme is actually installed
        if dconf list /org/gnome/terminal/legacy/profiles:/ 2>/dev/null | grep -q ":$profile_uuid/"; then
            themes["$index"]="$theme_name"
            theme_uuids["$index"]="$profile_uuid"
            ((index++))
        fi
    fi
done

if [[ ${#themes[@]} -eq 0 ]]; then
    echo -e "${YELLOW}No themes from this collection are currently installed.${NC}\n"
    exit 0
fi

# Display installed themes menu
echo -e "${BOLD}${BLUE}Installed Themes:${NC}"
echo -e "${YELLOW}-----------------------------------------${NC}"

max_index=${#themes[@]}
for ((i=1; i<=max_index; i++)); do
    if [[ -n "${themes[$i]}" ]]; then
        echo -e "${YELLOW}[${i}]${NC} ${themes[$i]}"
    fi
done

echo -e "${YELLOW}[A]${NC} Remove all themes"
echo -e "${YELLOW}[Q]${NC} Quit"
echo -e "${YELLOW}-----------------------------------------${NC}"

# Prompt for selection
echo ""
read -p "Select themes to remove (e.g., 1 3 5 or A for all): " -r selection

# Function to remove a theme
remove_theme() {
    local theme_name=$1
    local profile_uuid=$2
    
    echo -e "${BLUE}Removing $theme_name...${NC}"
    
    # Remove the profile configuration
    if dconf reset -f /org/gnome/terminal/legacy/profiles:/:$profile_uuid/ 2>/dev/null; then
        # Remove from profile list
        PROFILE_LIST=$(dconf read /org/gnome/terminal/legacy/profiles:/list)
        
        if [[ -n "$PROFILE_LIST" ]]; then
            # Remove this profile from the list
            NEW_LIST=$(echo "$PROFILE_LIST" | sed "s/, *'$profile_uuid'//g" | sed "s/'$profile_uuid' *, *//g" | sed "s/'$profile_uuid'//g")
            
            # Clean up empty list
            if [[ "$NEW_LIST" == "[]" ]]; then
                NEW_LIST="[]"
            fi
            
            dconf write /org/gnome/terminal/legacy/profiles:/list "$NEW_LIST" 2>/dev/null
        fi
        
        removed_themes["$theme_name"]="$theme_name"
        return 0
    else
        failed_themes["$theme_name"]="$theme_name"
        return 1
    fi
}

# Arrays to track removal outcomes
declare -A removed_themes
declare -A failed_themes

# Process the user's selection
if [[ "$selection" =~ ^[Aa]$ ]]; then
    # Remove all themes
    echo -e "\n${BLUE}Removing all themes...${NC}\n"
    for i in "${!themes[@]}"; do
        remove_theme "${themes[$i]}" "${theme_uuids[$i]}"
    done
elif [[ "$selection" =~ ^[Qq]$ ]]; then
    echo "Uninstall canceled."
    exit 0
else
    # Remove selected themes
    echo -e "\n${BLUE}Removing selected themes...${NC}\n"
    for index in $selection; do
        if [[ -n "${themes[$index]}" ]]; then
            remove_theme "${themes[$index]}" "${theme_uuids[$index]}"
        else
            echo -e "${RED}Invalid selection: $index${NC}"
        fi
    done
fi

# Display removal summary
echo -e "\n${BLUE}Uninstall Summary:${NC}"

if [[ ${#removed_themes[@]} -gt 0 ]]; then
    echo -e "${GREEN}✓ Removed themes:${NC}"
    while IFS= read -r theme; do
        echo "  - $theme"
    done < <(printf '%s\n' "${removed_themes[@]}" | sort)
fi

if [[ ${#failed_themes[@]} -gt 0 ]]; then
    echo -e "${RED}✗ Failed to remove:${NC}"
    while IFS= read -r theme; do
        echo "  - $theme"
    done < <(printf '%s\n' "${failed_themes[@]}" | sort)
fi

echo ""
