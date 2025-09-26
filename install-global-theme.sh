#!/bin/bash

# KawaiiBreezeDark Global Theme Installation Script
# Author: nawka12

set -e  # Exit on any error

echo "🌸 KawaiiBreezeDark Global Theme Installer 🌸"
echo "=============================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please don't run this script as root"
    exit 1
fi

# Check for required directories
print_step "Checking dependencies and creating directories..."

# Create necessary directories
mkdir -p ~/.local/share/plasma/look-and-feel/
mkdir -p ~/.local/share/color-schemes/
mkdir -p ~/.local/share/plasma/desktoptheme/

print_status "Directories created successfully"

# Check if KawaiiBreezeDark Plasma theme exists
if [ ! -d "KawaiiBreezeDark" ]; then
    print_error "KawaiiBreezeDark Plasma theme not found!"
    print_warning "Make sure the KawaiiBreezeDark folder is in the current directory"
    exit 1
fi

print_status "Found KawaiiBreezeDark Plasma theme"

# Check if Global theme folder exists
if [ ! -d "KawaiiBreezeDark-Global" ]; then
    print_error "KawaiiBreezeDark-Global folder not found!"
    print_warning "Make sure the KawaiiBreezeDark-Global folder is in the current directory"
    exit 1
fi

print_status "Found KawaiiBreezeDark Global theme"

# Install Plasma theme
print_step "Installing KawaiiBreezeDark Plasma theme..."
cp -r KawaiiBreezeDark ~/.local/share/plasma/desktoptheme/
print_status "Plasma theme installed to ~/.local/share/plasma/desktoptheme/"

# Install Global theme
print_step "Installing KawaiiBreezeDark Global theme..."
cp -r KawaiiBreezeDark-Global ~/.local/share/plasma/look-and-feel/
print_status "Global theme installed to ~/.local/share/plasma/look-and-feel/"

# Install color scheme
if [ -f "KawaiiBreezeDark.colors" ]; then
    print_step "Installing color scheme..."
    cp KawaiiBreezeDark.colors ~/.local/share/color-schemes/
    print_status "Color scheme installed to ~/.local/share/color-schemes/"
else
    print_warning "KawaiiBreezeDark.colors not found, skipping color scheme installation"
fi

# Set permissions
print_step "Setting proper permissions..."
chmod -R 755 ~/.local/share/plasma/look-and-feel/KawaiiBreezeDark-Global/
chmod -R 755 ~/.local/share/plasma/desktoptheme/KawaiiBreezeDark/
if [ -f ~/.local/share/color-schemes/KawaiiBreezeDark.colors ]; then
    chmod 644 ~/.local/share/color-schemes/KawaiiBreezeDark.colors
fi
print_status "Permissions set successfully"

# Check for optional dependencies
print_step "Checking for optional dependencies..."

# Check for GraphicalEffects
if ! dpkg -l | grep -q qt5-graphicaleffects 2>/dev/null && ! rpm -qa | grep -q qt5-graphicaleffects 2>/dev/null; then
    print_warning "qt5-graphicaleffects not found - splash screen effects may not work"
    echo "  Install with: sudo apt install qt5-graphicaleffects (Ubuntu/Debian)"
    echo "  Or: sudo dnf install qt5-qtgraphicaleffects (Fedora)"
    echo "  Or: sudo pacman -S qt5-graphicaleffects (Arch)"
fi

# Restart Plasma
read -p "$(echo -e ${CYAN}Would you like to restart Plasma now? [y/N]: ${NC})" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_step "Restarting Plasma..."
    kquitapp5 plasmashell && kstart5 plasmashell &
    print_status "Plasma restarted"
else
    print_warning "Please restart Plasma manually later:"
    echo "  kquitapp5 plasmashell && kstart5 plasmashell"
fi

echo
echo -e "${GREEN}🎉 Installation completed successfully! 🎉${NC}"
echo
echo "To apply the theme:"
echo "1. Open System Settings"
echo "2. Go to Appearance > Global Theme"
echo "3. Select 'KawaiiBreezeDark Global'"
echo "4. Click 'Apply'"
echo
echo -e "${PURPLE}Enjoy your new cyberpunk desktop! ✨${NC}" 