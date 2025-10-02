# XNAT Themes Installation Guide

This package contains 10 custom XNAT themes ready for deployment to your XNAT instance.

## Available Themes

1. **Ocean Blue** - Cool, professional blue theme with ocean-inspired gradients
2. **Forest Green** - Natural, calming green theme with earthy tones
3. **Sunset Orange** - Warm, energetic theme with sunset-inspired gradients
4. **Royal Purple** - Elegant, sophisticated purple theme with luxurious gradients
5. **Midnight Dark** - Modern dark theme with high contrast and blue accents
6. **Coral Reef** - Vibrant coral and teal theme inspired by tropical reefs
7. **Arctic Frost** - Clean, minimalist theme with cool blues and whites
8. **Golden Wheat** - Warm, earthy theme with golden yellows and rich browns
9. **Electric Lime** - High-energy theme with vibrant greens and electric accents
10. **Crimson Red** - Bold, powerful theme with deep reds and elegant contrasts

## Requirements

- XNAT 1.7.3 or higher
- Administrator access to your XNAT instance

## Installation Methods

### Method 1: Batch Upload All Themes (Recommended)

Upload all 10 themes at once using the batch upload script:

```bash
# Upload all themes to your XNAT instance
./upload-all-themes.sh https://your-xnat.org admin
```

This will upload all theme packages. You can then activate any theme through the web interface or use Method 2 below.

### Method 2: Single Theme Deployment

Deploy and activate a specific theme:

```bash
# Deploy a specific theme
./deploy-themes.sh https://your-xnat.org admin ocean-blue

# Interactive theme selection
./deploy-themes.sh https://your-xnat.org admin
```

### Method 3: Manual Upload via Web Interface

1. Log into your XNAT as an administrator
2. Navigate to **Administer** > **Site Administration** > **Plugin Settings** > **Themes**
3. Click **Upload Theme**
4. Select one of the `.zip` files from this package
5. Click **Upload**
6. Once uploaded, click **Activate** next to your theme

### Method 4: Manual Installation via Server

1. Extract the theme ZIP file to your XNAT webapp directory:
   ```bash
   unzip ocean-blue.zip -d /path/to/xnat/webapp/themes/
   ```

2. Restart your XNAT instance

3. Activate via REST API or web interface:
   ```bash
   curl -u admin:password -X PUT \
     -H "Content-Type: application/json" \
     -d '{"theme":"ocean-blue"}' \
     https://your-xnat.org/xapi/siteConfig/theme
   ```

## Theme Features

All themes in this collection:
- **Preserve the XNAT banner** - The XNAT logo and header section remain untouched
- **Color-only modifications** - No layout or structural changes to ensure compatibility
- **Standard XNAT navigation** - Maintains horizontal navigation bar with themed colors
- **Fully compatible** - Works with existing XNAT installations without conflicts

## Theme Structure

Each theme package contains:
- `css/theme.css` - Main theme stylesheet with color-only modifications
- `theme.properties` - Theme metadata and configuration

## Customization

To customize a theme:
1. Extract the ZIP file
2. Modify the `css/theme.css` file
3. Re-package as ZIP
4. Upload to your XNAT instance

## Troubleshooting

- **Upload fails**: Ensure you have administrator privileges
- **Theme doesn't activate**: Check XNAT logs for CSS errors
- **Styles not applied**: Clear browser cache and refresh

## Support

For issues or custom theme development, refer to the XNAT documentation:
- [XNAT Themes Documentation](https://wiki.xnat.org/documentation/working-with-ui-themes)
