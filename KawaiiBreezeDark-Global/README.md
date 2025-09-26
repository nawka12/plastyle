# KawaiiBreezeDark Global Theme

A comprehensive KDE Global Theme inspired by the KawaiiBreezeDark Plasma theme, featuring a dark anime-inspired aesthetic with neon effects and cyberpunk elements.

## Features

- **Complete Global Theme Package**: Includes plasma theme, color scheme, layout, and splash screen
- **Cyberpunk Aesthetic**: Dark backgrounds with neon purple, cyan, and green accents
- **Animated Splash Screen**: Custom QML splash with neon effects and grid overlay
- **Optimized Desktop Layout**: Configured panel with essential widgets
- **Enhanced Visual Effects**: Blur, translucency, and glow effects enabled

## Installation

### Automatic Installation (Recommended)

1. Copy the `KawaiiBreezeDark-Global` folder to `~/.local/share/plasma/look-and-feel/`
2. Copy the `KawaiiBreezeDark.colors` file to `~/.local/share/color-schemes/`
3. Open System Settings > Appearance > Global Theme
4. Select "KawaiiBreezeDark Global" from the list
5. Click "Apply" to activate the theme

### Manual Installation

```bash
# Create directories if they don't exist
mkdir -p ~/.local/share/plasma/look-and-feel/
mkdir -p ~/.local/share/color-schemes/

# Copy theme files
cp -r KawaiiBreezeDark-Global ~/.local/share/plasma/look-and-feel/
cp KawaiiBreezeDark.colors ~/.local/share/color-schemes/

# Restart Plasma to ensure proper loading
kquitapp5 plasmashell && kstart5 plasmashell
```

## Components Included

### Look and Feel Package
- **Plasma Theme**: KawaiiBreezeDark (must be installed separately)
- **Color Scheme**: Dark cyberpunk colors with neon accents
- **Desktop Layout**: Bottom panel with essential widgets
- **Splash Screen**: Custom animated splash with neon effects
- **Window Effects**: Blur, translucency, and enhanced compositing

### Color Palette
- **Primary Background**: `#14230b` (Very dark green-blue)
- **Secondary Background**: `#1e1428` (Dark purple)
- **Accent Colors**: 
  - Light Lavender: `#BDABE3` (Main accent color)
  - Neon Cyan: `#64ffff`
  - Neon Green: `#50ff96`
- **Text Colors**: Light purple/cyan variations

## Preview Images

To complete the theme package, create the following preview images:

### Required Images
1. **preview.png** (400x300px): Small preview for theme selection
2. **fullscreenpreview.jpg** (1920x1080px): Full desktop screenshot
3. **splash.jpg** (800x600px): Splash screen preview

### How to Create Previews

1. **Apply the theme** to your desktop
2. **Take screenshots** of:
   - Desktop with panel and widgets visible
   - Full screen showing wallpaper and all elements
   - Splash screen during login (or use screenshot of QML file)
3. **Resize and save** images in the `contents/previews/` folder
4. **File formats**: PNG for preview.png, JPG for others

### Preview Creation Commands
```bash
# After applying theme, take screenshots
spectacle --fullscreen --nonotify --output fullscreenpreview.jpg
spectacle --activewindow --nonotify --output preview.png

# Resize if needed
convert fullscreenpreview.jpg -resize 1920x1080^ fullscreenpreview.jpg
convert preview.png -resize 400x300^ preview.png
```

## Dependencies

### Required Plasma Theme
This Global Theme requires the **KawaiiBreezeDark** Plasma theme to be installed. Make sure to install it first:

```bash
# Copy the KawaiiBreezeDark folder to plasma themes directory
cp -r KawaiiBreezeDark ~/.local/share/plasma/desktoptheme/
```

### Recommended Packages
- **Breeze Window Decorations**: Used for window borders
- **Breeze Cursors**: Default cursor theme
- **Compositor Effects**: For blur and translucency

## Customization

### Modifying Colors
Edit `KawaiiBreezeDark.colors` to adjust the color scheme for applications.

### Changing Layout
Edit `contents/layouts/org.kde.plasma.desktop-layout.js` to modify the desktop layout.

### Splash Screen
Customize `contents/splash/Splash.qml` to change the splash screen appearance.

### Theme Settings
Modify `contents/defaults` to change which themes and effects are applied.

## Troubleshooting

### Theme Not Appearing
- Ensure both the Global Theme and Plasma Theme are installed
- Restart Plasma: `kquitapp5 plasmashell && kstart5 plasmashell`
- Check file permissions: `chmod -R 755 ~/.local/share/plasma/`
- Clear theme cache: `rm -rf ~/.cache/plasma*`

### Theme Replacing Another Theme (Important Fix)
If the theme appears to replace Breeze Dark instead of creating a new theme:
- This is fixed in version 1.0+ with unique theme ID `com.kayfahaarukku.kawaiibreezedarkg`
- Ensure you're using the latest version of the theme files
- If still occurring, manually remove any conflicting themes and reinstall

### Colors Not Applied
- Install the color scheme: `cp KawaiiBreezeDark.colors ~/.local/share/color-schemes/`
- Apply manually in System Settings > Colors
- Clear color cache: `kbuildsycoca5`

### Splash Screen Issues
- Ensure Qt5 GraphicalEffects are installed: `qt5-graphicaleffects`
- Check QML syntax if making modifications
- Test splash independently: `qdbus org.kde.KSplash /KSplash org.kde.KSplash.setStage 5`

### Testing the Theme
To properly test without affecting your current setup:
1. Create a test user account
2. Install the theme for that user
3. Apply and test all components
4. Once satisfied, install for your main account

## License

GPL - Same as the original KawaiiBreezeDark Plasma theme

## Credits

- **Author**: nawka12
- **Based on**: KawaiiBreezeDark Plasma Theme
- **Inspired by**: Cyberpunk aesthetics and anime themes 