# XNAT Custom Themes Collection

A comprehensive collection of 10 unique, professionally designed themes for XNAT (Neuroimaging Informatics Technology Initiative) platforms, complete with automated packaging and deployment tools.

## 🎨 Available Themes

| Theme | Description | Primary Colors |
|-------|-------------|----------------|
| **Ocean Blue** | Cool, professional theme with ocean-inspired gradients | Blue (#0066cc), Light Blue (#e6f3ff) |
| **Forest Green** | Natural, calming theme with earthy tones | Green (#2d5016), Light Green (#e8f5e8) |
| **Sunset Orange** | Warm, energetic theme with sunset gradients | Orange (#cc4400), Light Orange (#fff3e6) |
| **Royal Purple** | Elegant, sophisticated theme with luxurious styling | Purple (#663399), Light Purple (#f0ebf7) |
| **Midnight Dark** | Modern dark theme with high contrast and blue accents | Dark Gray (#1a1a1a), Blue (#2c2c54) |
| **Coral Reef** | Vibrant coral and teal theme inspired by tropical reefs | Coral (#ff6b6b), Teal (#4ecdc4) |
| **Arctic Frost** | Clean, minimalist theme with cool blues and whites | Gray (#718096), Light Gray (#f8fafb) |
| **Golden Wheat** | Warm, earthy theme with golden yellows and browns | Gold (#d69e2e), Light Gold (#fffdf7) |
| **Electric Lime** | High-energy theme with vibrant greens and electric accents | Lime (#84cc16), Light Lime (#f0fff4) |
| **Crimson Red** | Bold, powerful theme with deep reds and elegant contrasts | Red (#dc2626), Light Red (#fef2f2) |

## 📋 Requirements

- **XNAT Version**: 1.7.3 or higher
- **Access Level**: Administrator privileges required
- **Browser**: Modern browser with CSS3 support
- **Tools**: bash, curl, zip (for automated deployment)

## 🚀 Quick Start

### 1. Clone or Download
```bash
git clone <repository-url>
cd xnat_themes
```

### 2. Package All Themes
```bash
./package-themes.sh
```

### 3. Deploy to XNAT
```bash
cd packaged-themes
./deploy-themes.sh https://your-xnat.org admin
```

## 📦 Packaging System

The project includes a comprehensive packaging system with the following features:

### Main Packaging Script
```bash
./package-themes.sh [options]

Options:
  --help, -h     Show help message
  --list         List available themes
  --single NAME  Package only the specified theme
```

### Deployment Script
```bash
./deploy-themes.sh <xnat_url> <username> [theme_name]

Examples:
  ./deploy-themes.sh https://your-xnat.org admin ocean-blue
  ./deploy-themes.sh https://your-xnat.org admin  # Interactive selection
```

## 📁 Project Structure

```
xnat_themes/
├── README.md                    # This file
├── package-themes.sh           # Main packaging script
├── ocean-blue/
│   └── css/
│       └── theme.css          # Ocean Blue theme styles
├── forest-green/
│   └── css/
│       └── theme.css          # Forest Green theme styles
├── [... other themes ...]
└── packaged-themes/           # Generated after packaging
    ├── README.md              # Installation guide
    ├── deploy-themes.sh       # Deployment script
    ├── ocean-blue.zip         # Packaged theme
    └── [... other .zip files ...]
```

## 🛠️ Installation Methods

### Method 1: Automated Deployment (Recommended)

Use the provided deployment script for seamless installation:

```bash
cd packaged-themes
./deploy-themes.sh https://your-xnat.org admin ocean-blue
```

The script will:
- Upload the theme package via REST API
- Automatically activate the theme
- Provide success/failure feedback

### Method 2: Manual Web Interface Upload

1. Log into XNAT as administrator
2. Navigate to **Administer** → **Site Administration** → **Plugin Settings** → **Themes**
3. Click **Upload Theme**
4. Select a `.zip` file from `packaged-themes/`
5. Click **Upload** then **Activate**

### Method 3: Server-Side Installation

For direct server access:

```bash
# Extract theme to XNAT webapp directory
unzip ocean-blue.zip -d /path/to/xnat/webapp/themes/

# Restart XNAT service
sudo systemctl restart tomcat

# Activate via REST API
curl -u admin:password -X PUT \
  -H "Content-Type: application/json" \
  -d '{"theme":"ocean-blue"}' \
  https://your-xnat.org/xapi/siteConfig/theme
```

## 🎨 Theme Development

### CSS Structure

Each theme follows XNAT's standard structure:
- `css/theme.css` - Main stylesheet with complete UI styling
- `theme.properties` - Theme metadata and configuration

### Key CSS Classes Styled

- **Navigation**: `.topnav`, `.nav-link`
- **Tabs**: `.nav-tabs`, `.tab-content`
- **Buttons**: `.btn-primary`, `.primary-btn`
- **Panels**: `.panel`, `.card`, `.panel-heading`
- **Tables**: `table.dataTable`
- **Forms**: Input elements, selects, textareas
- **Alerts**: `.alert-*` classes

### Customization

To customize an existing theme:

1. Extract the theme ZIP file
2. Modify `css/theme.css` with your changes
3. Test locally if possible
4. Re-package using the script:
   ```bash
   ./package-themes.sh --single theme-name
   ```
5. Deploy the updated theme

## 🔧 Advanced Usage

### Creating Custom Themes

1. Create a new directory with your theme name:
   ```bash
   mkdir my-custom-theme
   mkdir my-custom-theme/css
   ```

2. Create `my-custom-theme/css/theme.css` with your styles

3. Add your theme to the `THEMES` array in `package-themes.sh`

4. Package and deploy:
   ```bash
   ./package-themes.sh --single my-custom-theme
   ```

### Bulk Operations

Package multiple specific themes:
```bash
for theme in ocean-blue forest-green midnight-dark; do
  ./package-themes.sh --single "$theme"
done
```

## 🐛 Troubleshooting

### Common Issues

**Theme upload fails:**
- Verify administrator privileges
- Check XNAT version compatibility (requires 1.7.3+)
- Ensure ZIP file is properly formatted

**Styles not applied:**
- Clear browser cache (Ctrl+F5 or Cmd+Shift+R)
- Check browser developer console for CSS errors
- Verify theme is activated in Site Administration

**Deployment script errors:**
- Ensure curl is installed and accessible
- Verify XNAT URL is correct and accessible
- Check network connectivity and firewall settings

### Debug Mode

Enable verbose output in deployment:
```bash
bash -x ./deploy-themes.sh https://your-xnat.org admin theme-name
```

## 📚 Resources

- [XNAT Documentation](https://wiki.xnat.org/)
- [XNAT Themes Guide](https://wiki.xnat.org/documentation/working-with-ui-themes)
- [XNAT REST API Documentation](https://wiki.xnat.org/xnat-api)
- [CSS Customization Guide](https://wiki.xnat.org/documentation/customizing-user-interfaces-in-xnat-plugins)

## 🤝 Contributing

To contribute new themes or improvements:

1. Fork the repository
2. Create a new theme directory following the established structure
3. Test your theme thoroughly
4. Update documentation as needed
5. Submit a pull request with detailed description

### Theme Guidelines

- Follow consistent naming conventions (kebab-case)
- Ensure high contrast for accessibility
- Test across major browsers
- Include comprehensive CSS coverage
- Document any special features or requirements

## 📄 License

This project is provided as-is for educational and customization purposes. Please ensure compliance with your organization's policies and XNAT licensing terms.

## 📞 Support

For issues related to:
- **Theme development**: Check XNAT documentation and community forums
- **XNAT installation**: Refer to official XNAT support channels
- **Custom modifications**: Consider consulting with XNAT developers or community

---

**Note**: These themes are designed for XNAT 1.7.3+ and may require adjustments for different versions. Always test themes in a development environment before deploying to production systems.