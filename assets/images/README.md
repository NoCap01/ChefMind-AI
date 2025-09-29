# ChefMind AI Logo Assets

This directory contains the official ChefMind AI logo and related brand assets.

## Logo Files

### `chefmind_logo.png`
- **Size**: 200x200px
- **Format**: PNG with transparency
- **Usage**: Primary logo for app UI, headers, and branding
- **Colors**: Emerald to Sky Blue gradient (#10B981 → #0EA5E9)

### `chefmind_logo.svg`
- **Format**: Scalable Vector Graphics
- **Usage**: Vector version for high-resolution displays and print
- **Benefits**: Infinitely scalable, smaller file size

## Logo Design

The ChefMind AI logo is a clever fusion of two key concepts:

1. **Chef's Hat** - Represents traditional cooking and culinary expertise
2. **Brain Pattern** - Represents artificial intelligence and smart cooking assistance

### Design Elements:
- **Shape**: Chef's hat silhouette with brain-like internal patterns
- **Colors**: Gradient from Emerald Green to Sky Blue
- **Style**: Modern, clean, and professional
- **Symbolism**: The perfect blend of culinary tradition and AI innovation

## Usage Guidelines

### In Flutter Widgets

#### Basic Logo Usage:
```dart
Image.asset(
  'assets/images/chefmind_logo.png',
  width: 48,
  height: 48,
)
```

#### With Color Overlay:
```dart
Image.asset(
  'assets/images/chefmind_logo.png',
  width: 48,
  height: 48,
  color: Colors.white, // Makes logo white
)
```

#### Using Custom Logo Widgets:
```dart
// Simple logo
ChefMindLogo(size: 32)

// Animated logo with pulsing effect
AnimatedChefMindLogo(size: 48, color: Colors.white)

// Logo header for splash/about screens
AppLogoHeader(
  logoSize: 80,
  subtitle: 'Your AI Cooking Assistant',
)
```

### Color Variations

The logo works well in several color schemes:

1. **Original Colors**: Emerald to Sky Blue gradient
2. **White**: For dark backgrounds and app bars
3. **Primary Theme**: Using app's primary color
4. **Monochrome**: Single color for minimal designs

### Size Guidelines

- **Small**: 16-24px (navigation, buttons)
- **Medium**: 32-48px (headers, cards)
- **Large**: 64-80px (splash screens, about pages)
- **Hero**: 100px+ (marketing, presentations)

## Brand Consistency

When using the ChefMind AI logo:

- ✅ Maintain aspect ratio
- ✅ Use appropriate sizes for context
- ✅ Ensure sufficient contrast with background
- ✅ Use fallback icons when logo fails to load
- ❌ Don't stretch or distort the logo
- ❌ Don't use low-resolution versions
- ❌ Don't change the core design elements

## Technical Notes

- Logo includes error handling with fallback to `Icons.restaurant_menu`
- Optimized for both light and dark themes
- Supports color overlays for theme consistency
- Available in both raster (PNG) and vector (SVG) formats