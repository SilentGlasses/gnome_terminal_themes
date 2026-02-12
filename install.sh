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

# GitHub repository info
GITHUB_USER="SilentGlasses"
GITHUB_REPO="gnome_terminal_themes"
GITHUB_BRANCH="main"
GITHUB_RAW_BASE="https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${GITHUB_BRANCH}"
GITHUB_API_BASE="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}"

# Detect if running locally or remotely
if [[ -n "${BASH_SOURCE[0]}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    THEMES_DIR="$SCRIPT_DIR/themes"
    if [[ -d "$THEMES_DIR" ]]; then
        RUN_MODE="local"
    else
        RUN_MODE="remote"
    fi
else
    RUN_MODE="remote"
fi

echo -e "\n${BOLD}${BLUE}GNOME TERMINAL THEME INSTALLER${NC}"
echo -e "${BLUE}For GNOME Terminal 3.52.0 (GNOME 46)${NC}\n"

# Check for dconf dependency
if ! command -v dconf &> /dev/null; then
    echo -e "${RED}Error: dconf is required but not installed.${NC}"
    echo -e "${YELLOW}Please install dconf and try again:${NC}"
    echo -e "${YELLOW}  sudo apt install dconf-cli${NC}"
    exit 1
fi

# Check for curl if running remotely
if [[ "$RUN_MODE" == "remote" ]] && ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is required for remote installation.${NC}"
    exit 1
fi

# Build theme list from available scripts
declare -A themes
declare -A theme_scripts
index=1

if [[ "$RUN_MODE" == "local" ]]; then
    # Local mode: read from themes/ directory
    for script in "$THEMES_DIR"/*.sh; do
        [[ -f "$script" ]] || continue
        # Skip utility scripts
        script_name=$(basename "$script")
        if [[ "$script_name" == "cleanup_invalid_profiles.sh" ]]; then
            continue
        fi

        # Extract theme name from the script
        theme_name=$(grep "^PROFILE_NAME=" "$script" | cut -d'"' -f2)

        if [[ -n "$theme_name" ]]; then
            themes["$index"]="$theme_name"
            theme_scripts["$index"]="$script"
            ((index++))
        fi
    done
else
    # Remote mode: fetch theme list from GitHub API
    echo -e "${BLUE}Fetching theme list from GitHub...${NC}"
    
    theme_list=$(curl -fsSL "${GITHUB_API_BASE}/contents/themes?ref=${GITHUB_BRANCH}" 2>/dev/null)
    
    if [[ -z "$theme_list" ]]; then
        echo -e "${RED}Error: Failed to fetch theme list from GitHub.${NC}"
        exit 1
    fi
    
    # Parse JSON to get .sh files (excluding utility scripts)
    while IFS= read -r script_name; do
        [[ -z "$script_name" ]] && continue
        [[ "$script_name" == "cleanup_invalid_profiles.sh" ]] && continue
        
        # Fetch script content to get theme name
        script_url="${GITHUB_RAW_BASE}/themes/${script_name}"
        script_content=$(curl -fsSL "$script_url" 2>/dev/null)
        
        if [[ -n "$script_content" ]]; then
            theme_name=$(echo "$script_content" | grep "^PROFILE_NAME=" | cut -d'"' -f2)
            
            if [[ -n "$theme_name" ]]; then
                themes["$index"]="$theme_name"
                theme_scripts["$index"]="$script_url"
                ((index++))
            fi
        fi
    done < <(echo "$theme_list" | grep -o '"name": *"[^"]*\.sh"' | sed 's/"name": *"//;s/"$//')
fi

if [[ ${#themes[@]} -eq 0 ]]; then
    echo -e "${RED}No theme installation scripts found.${NC}"
    exit 1
fi

# Display themes menu
echo -e "${BOLD}${BLUE}Available GNOME Terminal Themes:${NC}"
echo -e "${YELLOW}-----------------------------------------${NC}"

max_index=${#themes[@]}
for ((i=1; i<=max_index; i++)); do
    if [[ -n "${themes[$i]}" ]]; then
        echo -e "${YELLOW}[${i}]${NC} ${themes[$i]}"
    fi
done

echo -e "${YELLOW}[A]${NC} Install all themes"
echo -e "${YELLOW}[Q]${NC} Quit"
echo -e "${YELLOW}-----------------------------------------${NC}"

# Prompt for selection
echo ""
read -p "Select themes to install (e.g., 1 3 5 or A for all): " -r selection

# Function to install a theme
install_theme() {
    local theme_name=$1
    local script=$2
    local script_content
    local profile_uuid

    # Get script content based on run mode
    if [[ "$RUN_MODE" == "local" ]]; then
        script_content=$(cat "$script")
    else
        script_content=$(curl -fsSL "$script" 2>/dev/null)
    fi

    if [[ -z "$script_content" ]]; then
        failed_themes["$theme_name"]="$theme_name"
        return 1
    fi

    # Check if theme already exists by UUID
    profile_uuid=$(echo "$script_content" | grep "^PROFILE_UUID=" | cut -d'"' -f2)

    if dconf list /org/gnome/terminal/legacy/profiles:/ 2>/dev/null | grep -q ":$profile_uuid/"; then
        existing_themes["$theme_name"]="$theme_name"
        return 2
    fi

    echo -e "${BLUE}Installing $theme_name...${NC}"

    # Execute the script
    if echo "$script_content" | bash > /dev/null 2>&1; then
        installed_themes["$theme_name"]="$theme_name"
        return 0
    else
        failed_themes["$theme_name"]="$theme_name"
        return 1
    fi
}

# Arrays to track installation outcomes
declare -A installed_themes
declare -A existing_themes
declare -A failed_themes

# Process the user's selection
if [[ "$selection" =~ ^[Aa]$ ]]; then
    # Install all themes
    echo -e "\n${BLUE}Installing all themes...${NC}\n"
    for i in "${!themes[@]}"; do
        install_theme "${themes[$i]}" "${theme_scripts[$i]}"
    done
elif [[ "$selection" =~ ^[Qq]$ ]]; then
    echo "Installation canceled."
    exit 0
else
    # Install selected themes
    echo -e "\n${BLUE}Installing selected themes...${NC}\n"
    for index in $selection; do
        if [[ -n "${themes[$index]}" ]]; then
            install_theme "${themes[$index]}" "${theme_scripts[$index]}"
        else
            echo -e "${RED}Invalid selection: $index${NC}"
        fi
    done
fi

# Display installation summary
echo -e "\n${BLUE}Installation Summary:${NC}"

if [[ ${#installed_themes[@]} -gt 0 ]]; then
    echo -e "${GREEN}✓ Installed themes:${NC}"
    while IFS= read -r theme; do
        echo "  - $theme"
    done < <(printf '%s\n' "${installed_themes[@]}" | sort)
fi

if [[ ${#existing_themes[@]} -gt 0 ]]; then
    if [[ ${#installed_themes[@]} -eq 0 && ${#failed_themes[@]} -eq 0 ]]; then
        echo -e "${YELLOW}• All selected themes are already installed${NC}"
    else
        echo -e "${YELLOW}• Already installed themes:${NC}"
        while IFS= read -r theme; do
            echo "  - $theme"
        done < <(printf '%s\n' "${existing_themes[@]}" | sort)
    fi
fi

if [[ ${#failed_themes[@]} -gt 0 ]]; then
    echo -e "${RED}✗ Failed installations:${NC}"
    while IFS= read -r theme; do
        echo "  - $theme"
    done < <(printf '%s\n' "${failed_themes[@]}" | sort)
fi

echo -e "\n${BLUE}To use your new themes:${NC}"
echo -e "  1. Open GNOME Terminal"
echo -e "  2. Go to Preferences (☰ → Preferences)"
echo -e "  3. Select your desired theme from the profiles list"
echo -e "  4. Set as default if desired\n"
