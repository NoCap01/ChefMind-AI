# ChefMind AI App Icons

This directory contains the app launcher icons for ChefMind AI.

## Icon Design

The ChefMind AI icon features:

- **Background**: Modern gradient from Indigo (#6366F1) to Violet (#8B5CF6)
- **Main Element**: White chef's hat with traditional pleated design
- **Accent**: Emerald green band around the hat base
- **AI Elements**: Golden sparkles representing AI intelligence
- **Supporting Elements**: Subtle cooking utensils (spoon and fork) in the background

## Color Palette

- **Primary**: Indigo (#6366F1) to Violet (#8B5CF6) gradient
- **Secondary**: Emerald Green (#10B981) for the chef hat band
- **Accent**: Amber (#F59E0B) for AI sparkles
- **Base**: White (#FFFFFF) for the chef hat
- **Background**: Slate colors for subtle elements

## Files

- `app_icon_1024.png` - Master icon file (1024x1024px)
- `app_icon.svg` - Vector version of the icon
- `app_icon_simple.svg` - Simplified vector version

## Generated Icons

The `flutter_launcher_icons` package automatically generates platform-specific icons:

### Android
- Various densities (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- Adaptive icons with background and foreground layers

### iOS
- Multiple sizes for different devices and contexts
- Alpha channel removed for App Store compliance

### Web
- PWA icons (192x192, 512x512)
- Maskable icons for modern browsers

### Desktop
- Windows ICO format
- macOS ICNS format

## Usage

To regenerate icons after making changes:

```bash
flutter pub run flutter_launcher_icons
```

## Design Philosophy

The icon represents the fusion of traditional cooking (chef's hat) with modern AI technology (sparkles), embodying ChefMind AI's mission to enhance cooking through intelligent assistance.