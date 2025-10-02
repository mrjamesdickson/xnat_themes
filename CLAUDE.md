# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an XNAT theme collection containing 10 professionally designed themes for XNAT (Neuroimaging Informatics Technology Initiative) platforms. The project focuses on providing complete theme packages with automated deployment tools.

## Available Themes

- `ocean-blue`, `forest-green`, `sunset-orange`, `royal-purple`, `midnight-dark`
- `coral-reef`, `arctic-frost`, `golden-wheat`, `electric-lime`, `crimson-red`

Each theme directory contains:
- `css/theme.css` - Complete theme stylesheet
- `theme.properties` - Theme metadata
- `images/` - Theme-specific assets (when present)

## Key Commands

### Theme Packaging
```bash
# Package all themes
./package-themes.sh

# Package specific theme
./package-themes.sh --single theme-name

# List available themes
./package-themes.sh --list
```

### Theme Updates
```bash
# Update all themes with color-only changes (preserves XNAT structure)
./update_themes_colors_only.sh

# Comprehensive theme updates
./update_themes_comprehensive.sh

# Basic theme updates
./update_themes.sh
```

### Deployment
```bash
# Deploy themes to XNAT instance
cd packaged-themes
./deploy-themes.sh https://your-xnat.org admin theme-name
```

## Architecture

### Theme Structure
Each theme follows XNAT's standard structure:
- CSS uses CSS custom properties (CSS variables) to override XNAT defaults
- Themes preserve existing XNAT layout and structure completely
- **Color-only modifications** - no layout, positioning, or structural changes
- Maintains standard XNAT horizontal navigation bar
- Compatible with existing XNAT installations without layout conflicts

### Key CSS Patterns
- `--XNAT-blue-500`, `--XNAT-blue-600` etc. - XNAT CSS variable overrides
- `--theme-primary`, `--theme-secondary`, `--theme-accent` - Theme-specific color variables
- Focus on color changes for: navigation (`#main_nav`), tabs (`.nav-tabs`), buttons (`.btn-primary`), panels, tables
- YUI framework elements intentionally preserved (`.yui-nav`, `.yui-content`, `.pad` classes)
- NO layout modifications (positioning, width, height, flex-direction, etc.)

### Packaging System
- `package-themes.sh` - Main packaging script that creates deployable ZIP files
- Output goes to `packaged-themes/` directory
- Each theme gets packaged with proper XNAT structure

### Color Update System
The `update_themes_colors_only.sh` script systematically updates theme colors:
- Uses predefined color palettes for each theme (primary, secondary, accent, background, border, text)
- Generates color-only CSS files with NO layout modifications
- Preserves XNAT's standard horizontal navigation and page structure
- Updates only color-related properties (background-color, color, border-color)
- Maintains full compatibility with XNAT's default layout

## Development Workflow

1. Modify theme CSS files in individual theme directories
2. Use update scripts to apply systematic changes across themes
3. Package themes using `./package-themes.sh`
4. Test deployment on XNAT instance

## Requirements
- XNAT 1.7.3 or higher
- Administrator privileges for deployment
- bash, curl, zip tools for packaging/deployment