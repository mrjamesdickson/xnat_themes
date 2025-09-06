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
