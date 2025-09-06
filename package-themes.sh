#!/bin/bash

# XNAT Theme Packaging and Deployment Script
# This script packages XNAT themes into deployable ZIP files and provides deployment options

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/packaged-themes"
THEMES_DIR="${SCRIPT_DIR}"
TEMP_DIR="${SCRIPT_DIR}/.temp"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Theme list
THEMES=(
    "ocean-blue"
    "forest-green"
    "sunset-orange"
    "royal-purple"
    "midnight-dark"
    "coral-reef"
    "arctic-frost"
    "golden-wheat"
    "electric-lime"
    "crimson-red"
)

# Functions
print_header() {
    echo -e "${BLUE}=================================================${NC}"
    echo -e "${BLUE}         XNAT Theme Packaging Script${NC}"
    echo -e "${BLUE}=================================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Create necessary directories
create_directories() {
    print_info "Creating directories..."
    mkdir -p "$OUTPUT_DIR"
    mkdir -p "$TEMP_DIR"
    print_success "Directories created"
}

# Create theme.properties file for each theme
create_theme_properties() {
    local theme_name=$1
    local theme_dir=$2
    local display_name=$3
    
    cat > "$theme_dir/theme.properties" << EOF
# XNAT Theme Properties
theme.id=$theme_name
theme.name=$display_name
theme.description=Custom XNAT theme: $display_name
theme.version=1.0.0
theme.author=XNAT Theme Generator
theme.xnat.min.version=1.7.3
EOF
}

# Package individual theme
package_theme() {
    local theme_name=$1
    local theme_dir="${THEMES_DIR}/${theme_name}"
    
    if [ ! -d "$theme_dir" ]; then
        print_error "Theme directory not found: $theme_dir"
        return 1
    fi
    
    print_info "Packaging theme: $theme_name"
    
    # Create display name (convert kebab-case to Title Case)
    local display_name=$(echo "$theme_name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    
    # Create theme.properties
    create_theme_properties "$theme_name" "$theme_dir" "$display_name"
    
    # Create temporary packaging directory
    local temp_theme_dir="${TEMP_DIR}/${theme_name}"
    mkdir -p "$temp_theme_dir"
    
    # Copy theme files
    cp -r "$theme_dir"/* "$temp_theme_dir/"
    
    # Create ZIP package
    local zip_file="${OUTPUT_DIR}/${theme_name}.zip"
    (cd "$TEMP_DIR" && zip -r "${theme_name}.zip" "$theme_name/" -q)
    mv "${TEMP_DIR}/${theme_name}.zip" "$zip_file"
    
    # Cleanup temp directory for this theme
    rm -rf "$temp_theme_dir"
    
    print_success "Created: ${zip_file}"
}

# Package all themes
package_all_themes() {
    print_info "Packaging all themes..."
    
    local success_count=0
    local total_count=${#THEMES[@]}
    
    for theme in "${THEMES[@]}"; do
        if package_theme "$theme"; then
            ((success_count++))
        fi
    done
    
    echo
    print_success "Successfully packaged $success_count out of $total_count themes"
}

# Create deployment script
create_deployment_script() {
    print_info "Creating deployment script..."
    
    cat > "$OUTPUT_DIR/deploy-themes.sh" << 'EOF'
#!/bin/bash

# XNAT Theme Deployment Script
# Usage: ./deploy-themes.sh <xnat_url> <username> [theme_name]

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

if [ $# -lt 2 ]; then
    echo "Usage: $0 <xnat_url> <username> [theme_name]"
    echo "Example: $0 https://your-xnat.org admin ocean-blue"
    echo "If theme_name is not provided, you'll be prompted to select one."
    exit 1
fi

XNAT_URL="$1"
USERNAME="$2"
THEME_NAME="$3"

# Remove trailing slash from URL
XNAT_URL="${XNAT_URL%/}"

# Get password
echo -n "Enter password for $USERNAME: "
read -s PASSWORD
echo

# List available themes if none specified
if [ -z "$THEME_NAME" ]; then
    echo "Available themes:"
    ls -1 *.zip 2>/dev/null | sed 's/\.zip$//' | nl
    echo
    echo -n "Enter theme name (or number): "
    read THEME_INPUT
    
    # Check if input is a number
    if [[ "$THEME_INPUT" =~ ^[0-9]+$ ]]; then
        THEME_NAME=$(ls -1 *.zip 2>/dev/null | sed 's/\.zip$//' | sed -n "${THEME_INPUT}p")
    else
        THEME_NAME="$THEME_INPUT"
    fi
fi

ZIP_FILE="${THEME_NAME}.zip"

if [ ! -f "$ZIP_FILE" ]; then
    print_error "Theme file not found: $ZIP_FILE"
    exit 1
fi

print_info "Deploying theme: $THEME_NAME"
print_info "Target XNAT: $XNAT_URL"

# Upload theme via XNAT REST API
print_info "Uploading theme package..."

UPLOAD_RESPONSE=$(curl -s -u "$USERNAME:$PASSWORD" \
    -X POST \
    -F "file=@$ZIP_FILE" \
    "$XNAT_URL/xapi/themes" \
    -w "HTTP_STATUS:%{http_code}")

HTTP_STATUS=$(echo "$UPLOAD_RESPONSE" | grep -o "HTTP_STATUS:[0-9]*" | cut -d: -f2)
RESPONSE_BODY=$(echo "$UPLOAD_RESPONSE" | sed 's/HTTP_STATUS:[0-9]*$//')

if [ "$HTTP_STATUS" -eq 200 ] || [ "$HTTP_STATUS" -eq 201 ]; then
    print_success "Theme uploaded successfully"
    
    # Activate the theme
    print_info "Activating theme..."
    
    ACTIVATE_RESPONSE=$(curl -s -u "$USERNAME:$PASSWORD" \
        -X PUT \
        -H "Content-Type: application/json" \
        -d "{\"theme\":\"$THEME_NAME\"}" \
        "$XNAT_URL/xapi/siteConfig/theme" \
        -w "HTTP_STATUS:%{http_code}")
    
    ACTIVATE_HTTP_STATUS=$(echo "$ACTIVATE_RESPONSE" | grep -o "HTTP_STATUS:[0-9]*" | cut -d: -f2)
    
    if [ "$ACTIVATE_HTTP_STATUS" -eq 200 ]; then
        print_success "Theme activated successfully!"
        print_info "The theme '$THEME_NAME' is now active on your XNAT instance."
    else
        print_warning "Theme uploaded but activation failed. You can activate it manually in the Site Admin panel."
    fi
else
    print_error "Upload failed with HTTP status: $HTTP_STATUS"
    print_error "Response: $RESPONSE_BODY"
    exit 1
fi
EOF
    
    chmod +x "$OUTPUT_DIR/deploy-themes.sh"
    print_success "Created deployment script: deploy-themes.sh"
}

# Create installation instructions
create_instructions() {
    print_info "Creating installation instructions..."
    
    cat > "$OUTPUT_DIR/README.md" << 'EOF'
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

### Method 1: Automatic Deployment (Recommended)

Use the provided deployment script:

```bash
# Deploy a specific theme
./deploy-themes.sh https://your-xnat.org admin ocean-blue

# Interactive theme selection
./deploy-themes.sh https://your-xnat.org admin
```

### Method 2: Manual Upload via Web Interface

1. Log into your XNAT as an administrator
2. Navigate to **Administer** > **Site Administration** > **Plugin Settings** > **Themes**
3. Click **Upload Theme**
4. Select one of the `.zip` files from this package
5. Click **Upload**
6. Once uploaded, click **Activate** next to your theme

### Method 3: Manual Installation via Server

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

## Theme Structure

Each theme package contains:
- `css/theme.css` - Main theme stylesheet
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
EOF
    
    print_success "Created installation instructions: README.md"
}

# Main execution
main() {
    print_header
    
    create_directories
    package_all_themes
    create_deployment_script
    create_instructions
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    echo
    print_success "All themes packaged successfully!"
    print_info "Output directory: $OUTPUT_DIR"
    print_info "To deploy themes, use: cd $OUTPUT_DIR && ./deploy-themes.sh"
    
    echo
    echo -e "${BLUE}Package Contents:${NC}"
    ls -la "$OUTPUT_DIR"
}

# Command line options
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [options]"
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --list         List available themes"
        echo "  --single NAME  Package only the specified theme"
        exit 0
        ;;
    --list)
        echo "Available themes:"
        printf '%s\n' "${THEMES[@]}"
        exit 0
        ;;
    --single)
        if [ -z "$2" ]; then
            print_error "Theme name required with --single option"
            exit 1
        fi
        print_header
        create_directories
        package_theme "$2"
        rm -rf "$TEMP_DIR"
        exit 0
        ;;
    *)
        main
        ;;
esac