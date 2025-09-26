#!/bin/bash

# KawaiiBreezeDark Global Theme Verification Script
# Author: nawka12

echo "🔍 KawaiiBreezeDark Global Theme Verification"
echo "=============================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to print colored output
print_check() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

print_info() {
    echo -e "${CYAN}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if Global Theme is installed
echo "📁 Checking Global Theme Installation..."
if [ -d ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global ]; then
    print_check 0 "Global Theme directory found"
    
    # Check required files
    if [ -f ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/metadata.desktop ]; then
        print_check 0 "metadata.desktop found"
    else
        print_check 1 "metadata.desktop missing"
    fi
    
    if [ -f ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/contents/defaults ]; then
        print_check 0 "defaults file found"
    else
        print_check 1 "defaults file missing"
    fi
    
    if [ -f ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/contents/splash/Splash.qml ]; then
        print_check 0 "Splash.qml found"
    else
        print_check 1 "Splash.qml missing"
    fi
    
    if [ -f ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/contents/layouts/org.kde.plasma.desktop-layout.js ]; then
        print_check 0 "Desktop layout found"
    else
        print_check 1 "Desktop layout missing"
    fi
    
else
    print_check 1 "Global Theme directory not found"
    echo "  Install with: ./install-global-theme.sh"
fi

echo

# Check if Plasma Theme is installed
echo "🎨 Checking Plasma Theme Installation..."
if [ -d ~/.local/share/plasma/desktoptheme/KawaiiBreezeDark ]; then
    print_check 0 "KawaiiBreezeDark Plasma theme found"
else
    print_check 1 "KawaiiBreezeDark Plasma theme not found"
    echo "  Required for Global Theme to work properly"
fi

echo

# Check if Color Scheme is installed
echo "🌈 Checking Color Scheme Installation..."
if [ -f ~/.local/share/color-schemes/KawaiiBreezeDark.colors ]; then
    print_check 0 "KawaiiBreezeDark color scheme found"
else
    print_check 1 "KawaiiBreezeDark color scheme not found"
    echo "  Install with: cp KawaiiBreezeDark.colors ~/.local/share/color-schemes/"
fi

echo

# Check Theme ID uniqueness
echo "🔐 Checking Theme ID Uniqueness..."
if grep -q "com.kayfahaarukku.kawaiibreezedarkg" ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/metadata.desktop 2>/dev/null; then
    print_check 0 "Unique theme ID found (com.kayfahaarukku.kawaiibreezedarkg)"
else
    print_check 1 "Theme ID may conflict with existing themes"
    print_warning "This could cause the theme to replace Breeze Dark"
fi

echo

# Check for conflicts
echo "⚠️  Checking for Potential Conflicts..."
GLOBAL_THEMES=$(find ~/.local/share/plasma/look-and-feel/ -name "metadata.desktop" 2>/dev/null | wc -l)
print_info "Found $GLOBAL_THEMES Global Theme(s) installed"

# List existing Global Themes
if [ $GLOBAL_THEMES -gt 0 ]; then
    echo "   Installed Global Themes:"
    find ~/.local/share/plasma/look-and-feel/ -name "metadata.desktop" 2>/dev/null | while read -r file; do
        theme_name=$(grep "^Name=" "$file" | cut -d'=' -f2 | head -1)
        theme_id=$(grep "X-KDE-PluginInfo-Name=" "$file" | cut -d'=' -f2)
        echo "   - $theme_name ($theme_id)"
    done
fi

echo

# Check dependencies
echo "📦 Checking Dependencies..."
if command -v plasmashell >/dev/null 2>&1; then
    print_check 0 "Plasma Shell found"
else
    print_check 1 "Plasma Shell not found"
fi

if dpkg -l | grep -q qt5-graphicaleffects 2>/dev/null || rpm -qa | grep -q qt5-graphicaleffects 2>/dev/null || pacman -Q qt5-graphicaleffects >/dev/null 2>&1; then
    print_check 0 "Qt5 GraphicalEffects found"
else
    print_check 1 "Qt5 GraphicalEffects not found (splash screen effects may not work)"
    print_warning "Install with your package manager (qt5-graphicaleffects)"
fi

echo

# Test availability in system
echo "🖥️  Testing System Recognition..."
if kreadconfig5 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments >/dev/null 2>&1; then
    print_check 0 "Plasma configuration accessible"
else
    print_check 1 "Cannot access Plasma configuration"
fi

echo

# Final recommendations
echo "💡 Recommendations:"
echo "1. Clear Plasma cache before applying: rm -rf ~/.cache/plasma*"
echo "2. Restart Plasma after installation: kquitapp5 plasmashell && kstart5 plasmashell"
echo "3. Apply theme in System Settings > Appearance > Global Theme"
echo "4. If issues occur, test with a new user account first"

echo
echo -e "${GREEN}Verification complete!${NC}" 