#!/bin/bash

# XNAT Batch Theme Upload Script
# Uploads all packaged themes to an XNAT instance
# Usage: ./upload-all-themes.sh <xnat_url> <username>

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

if [ $# -lt 2 ]; then
    echo "Usage: $0 <xnat_url> <username>"
    echo "Example: $0 https://your-xnat.org admin"
    echo ""
    echo "This script will upload ALL theme packages to your XNAT instance."
    exit 1
fi

XNAT_URL="$1"
USERNAME="$2"

# Remove trailing slash from URL
XNAT_URL="${XNAT_URL%/}"

# Get password
echo -n "Enter password for $USERNAME: "
read -s PASSWORD
echo

print_info "Target XNAT: $XNAT_URL"
print_info "Finding theme packages..."

# Find all ZIP files
THEME_FILES=(*.zip)

if [ ${#THEME_FILES[@]} -eq 0 ] || [ ! -f "${THEME_FILES[0]}" ]; then
    print_error "No theme packages found in current directory"
    exit 1
fi

print_info "Found ${#THEME_FILES[@]} theme package(s)"
echo ""

# Counters
UPLOADED=0
FAILED=0

# Upload each theme
for ZIP_FILE in "${THEME_FILES[@]}"; do
    THEME_NAME="${ZIP_FILE%.zip}"

    echo "================================================="
    print_info "Uploading: $THEME_NAME"

    # Upload theme via XNAT REST API
    UPLOAD_RESPONSE=$(curl -s -u "$USERNAME:$PASSWORD" \
        -X POST \
        -F "themePackage=@$ZIP_FILE;type=application/zip" \
        "$XNAT_URL/xapi/themes" \
        -w "HTTP_STATUS:%{http_code}")

    HTTP_STATUS=$(echo "$UPLOAD_RESPONSE" | grep -o "HTTP_STATUS:[0-9]*" | cut -d: -f2)
    RESPONSE_BODY=$(echo "$UPLOAD_RESPONSE" | sed 's/HTTP_STATUS:[0-9]*$//')

    if [ "$HTTP_STATUS" -eq 200 ] || [ "$HTTP_STATUS" -eq 201 ]; then
        print_success "$THEME_NAME uploaded successfully"
        ((UPLOADED++))
    else
        print_error "$THEME_NAME upload failed (HTTP $HTTP_STATUS)"
        print_error "Response: $RESPONSE_BODY"
        ((FAILED++))
    fi

    echo ""
done

# Summary
echo "================================================="
echo "Upload Summary:"
print_success "Successfully uploaded: $UPLOADED"
if [ $FAILED -gt 0 ]; then
    print_error "Failed: $FAILED"
fi

if [ $UPLOADED -gt 0 ]; then
    echo ""
    print_info "Themes uploaded successfully!"
    print_info "To activate a theme, use: ./deploy-themes.sh $XNAT_URL $USERNAME <theme-name>"
    print_info "Or activate it manually through the XNAT Site Admin panel."
fi

exit 0
