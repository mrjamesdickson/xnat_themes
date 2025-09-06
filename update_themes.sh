#!/bin/bash

# XNAT Theme Comprehensive Update Script
# This script updates all themes with comprehensive XNAT element styling

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Function to generate comprehensive theme CSS
generate_theme_css() {
    local theme_name=$1
    local primary_color=$2
    local secondary_color=$3
    local tertiary_color=$4
    local light_bg=$5
    local text_color=$6
    local theme_description=$7
    
    cat > "${SCRIPT_DIR}/${theme_name}/css/theme.css" << EOF
/**
 * ${theme_description}
 * Comprehensive styling for all XNAT UI elements
 */

/* =============================================================================
   BASE STYLES
   ============================================================================= */

.yui-skin-sam {
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif !important;
}

body {
    background-color: ${light_bg} !important;
    color: ${text_color} !important;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif !important;
}

/* =============================================================================
   NAVIGATION ELEMENTS
   ============================================================================= */

#header, .topnav {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border-bottom: 3px solid ${tertiary_color} !important;
}

.topnav a, .topnav .nav-link {
    color: #ffffff !important;
    font-weight: 500 !important;
    transition: background-color 0.3s ease !important;
}

.topnav a:hover, .topnav .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.2) !important;
    color: rgba(255, 255, 255, 0.9) !important;
}

.yui-skin-sam .yuimenubar {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border-bottom: 2px solid ${tertiary_color} !important;
}

.yui-skin-sam .yuimenubaritemlabel {
    color: #ffffff !important;
    font-weight: 500 !important;
    background: transparent !important;
}

.yui-skin-sam .yuimenubaritemlabel:hover,
.yui-skin-sam .yuimenubaritemlabel-selected {
    background-color: rgba(255, 255, 255, 0.2) !important;
    color: rgba(255, 255, 255, 0.9) !important;
}

.yui-skin-sam .yuimenubaritemlabel-disabled {
    color: rgba(255, 255, 255, 0.5) !important;
}

.yui-skin-sam .yui-navset .yui-nav {
    border-bottom: 5px solid ${primary_color} !important;
    background: ${light_bg} !important;
}

.yui-skin-sam .yui-navset .yui-nav li {
    background: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-bottom: none !important;
    margin-right: 2px !important;
}

.yui-skin-sam .yui-navset .yui-nav li a {
    color: ${primary_color} !important;
    font-weight: 500 !important;
    padding: 8px 16px !important;
    text-decoration: none !important;
}

.yui-skin-sam .yui-navset .yui-nav li a:hover {
    background-color: rgba(0,0,0,0.05) !important;
}

.yui-skin-sam .yui-navset .yui-nav .selected {
    background: ${primary_color} !important;
    border-color: ${tertiary_color} !important;
}

.yui-skin-sam .yui-navset .yui-nav .selected a {
    color: #ffffff !important;
    background: transparent !important;
}

.yui-skin-sam .yui-navset .yui-content {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-top: none !important;
    padding: 20px !important;
}

/* =============================================================================
   DIALOG/PANEL ELEMENTS
   ============================================================================= */

.yui-skin-sam .yui-panel-container {
    box-shadow: 0 4px 20px rgba(0,0,0,0.15) !important;
}

.yui-skin-sam .yui-panel {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
}

.yui-skin-sam .yui-dialog .hd,
.yui-skin-sam .yui-panel .hd {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    border-bottom: 1px solid ${tertiary_color} !important;
    border-radius: 8px 8px 0 0 !important;
    padding: 12px 16px !important;
}

.yui-skin-sam .yui-dialog .bd,
.yui-skin-sam .yui-panel .bd {
    background-color: #ffffff !important;
    padding: 20px !important;
    color: ${text_color} !important;
}

.yui-skin-sam .yui-dialog .ft,
.yui-skin-sam .yui-panel .ft {
    background: ${light_bg} !important;
    border-top: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 0 0 8px 8px !important;
    padding: 12px 16px !important;
}

.yui-skin-sam .mask {
    background-color: rgba(0,0,0,0.4) !important;
}

/* =============================================================================
   BUTTON ELEMENTS
   ============================================================================= */

.yui-skin-sam .yui-button {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border: 1px solid ${tertiary_color} !important;
    border-radius: 4px !important;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2) !important;
}

.yui-skin-sam .yui-button .first-child {
    border: none !important;
}

.yui-skin-sam .yui-button button,
.yui-skin-sam .yui-button a {
    color: #ffffff !important;
    font-weight: 500 !important;
    background: transparent !important;
    padding: 8px 16px !important;
}

.yui-skin-sam .yui-button-hover {
    background: linear-gradient(135deg, ${secondary_color}, ${tertiary_color}) !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3) !important;
}

.yui-skin-sam .yui-button-active {
    background: ${tertiary_color} !important;
    transform: translateY(0) !important;
    box-shadow: 0 2px 4px rgba(0,0,0,0.4) !important;
}

.yui-skin-sam .yui-button-disabled {
    background: #e6e6e6 !important;
    border-color: #cccccc !important;
    box-shadow: none !important;
}

.yui-skin-sam .yui-button-disabled button,
.yui-skin-sam .yui-button-disabled a {
    color: #999999 !important;
}

.btn-primary, .primary-btn,
input[type="submit"], input[type="button"], button {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border: 1px solid ${tertiary_color} !important;
    color: #ffffff !important;
    font-weight: 500 !important;
    padding: 8px 16px !important;
    border-radius: 4px !important;
    cursor: pointer !important;
    transition: all 0.3s ease !important;
}

.btn-primary:hover, .primary-btn:hover,
input[type="submit"]:hover, input[type="button"]:hover, button:hover {
    background: linear-gradient(135deg, ${secondary_color}, ${tertiary_color}) !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3) !important;
}

/* =============================================================================
   TABLE/GRID ELEMENTS
   ============================================================================= */

.yui-skin-sam .yui-dt-table {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-collapse: separate !important;
    border-spacing: 0 !important;
}

.yui-skin-sam .yui-dt-hd {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border-bottom: 2px solid ${tertiary_color} !important;
}

.yui-skin-sam th.yui-dt-sortable,
.yui-skin-sam .yui-dt-hd th {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    padding: 12px 8px !important;
    border-right: 1px solid rgba(255, 255, 255, 0.3) !important;
}

.yui-skin-sam th.yui-dt-sortable:hover {
    background: linear-gradient(135deg, ${secondary_color}, ${tertiary_color}) !important;
}

.yui-skin-sam th.yui-dt-selected {
    background: ${tertiary_color} !important;
}

.yui-skin-sam tr.yui-dt-even {
    background-color: rgba(0,0,0,0.02) !important;
}

.yui-skin-sam tr.yui-dt-odd {
    background-color: #ffffff !important;
}

.yui-skin-sam tr.yui-dt-selected {
    background-color: ${light_bg} !important;
    color: ${primary_color} !important;
}

.yui-skin-sam .yui-dt-table tbody tr:hover {
    background-color: ${light_bg} !important;
}

table.dataTable {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-collapse: separate !important;
    border-spacing: 0 !important;
}

table.dataTable thead th {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    padding: 12px 8px !important;
}

table.dataTable tbody tr:hover {
    background-color: ${light_bg} !important;
}

table.dataTable tbody tr:nth-child(even) {
    background-color: rgba(0,0,0,0.02) !important;
}

/* =============================================================================
   FORM ELEMENTS
   ============================================================================= */

input[type="text"], input[type="password"], input[type="email"], 
input[type="number"], input[type="search"], input[type="tel"],
select, textarea {
    background-color: #ffffff !important;
    border: 2px solid rgba(0,0,0,0.1) !important;
    border-radius: 4px !important;
    padding: 8px 12px !important;
    color: ${text_color} !important;
    font-size: 14px !important;
    transition: all 0.3s ease !important;
}

input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus,
input[type="number"]:focus, input[type="search"]:focus, input[type="tel"]:focus,
select:focus, textarea:focus {
    border-color: ${primary_color} !important;
    box-shadow: 0 0 8px rgba(0,0,0,0.1) !important;
    outline: none !important;
}

input[type="text"]:disabled, input[type="password"]:disabled,
select:disabled, textarea:disabled {
    background-color: #f5f5f5 !important;
    border-color: #e0e0e0 !important;
    color: #999999 !important;
}

label {
    color: ${text_color} !important;
    font-weight: 500 !important;
    margin-bottom: 4px !important;
    display: inline-block !important;
}

/* =============================================================================
   CALENDAR/DATE PICKER
   ============================================================================= */

.yui-skin-sam .yui-calcontainer {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
}

.yui-skin-sam .yui-calendar .calheader {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    padding: 12px !important;
    border-radius: 8px 8px 0 0 !important;
}

.yui-skin-sam .yui-calendar td.calcell.today {
    background-color: ${primary_color} !important;
}

.yui-skin-sam .yui-calendar td.calcell.today a {
    color: #ffffff !important;
    font-weight: bold !important;
}

.yui-skin-sam .yui-calendar td.calcell.selected a {
    background-color: ${light_bg} !important;
    color: ${primary_color} !important;
    font-weight: 600 !important;
}

.yui-skin-sam .yui-calendar td.calcell.calcellhover {
    background-color: ${primary_color} !important;
}

.yui-skin-sam .yui-calendar td.calcell.calcellhover a {
    background-color: ${primary_color} !important;
    color: #ffffff !important;
}

/* =============================================================================
   MENU/DROPDOWN ELEMENTS
   ============================================================================= */

.yui-skin-sam .yuimenu {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 6px !important;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
}

.yui-skin-sam .yuimenuitemlabel {
    color: ${text_color} !important;
    padding: 10px 16px !important;
    background: transparent !important;
    transition: background-color 0.2s ease !important;
}

.yui-skin-sam .yuimenuitemlabel:hover {
    background-color: ${light_bg} !important;
    color: ${primary_color} !important;
}

/* =============================================================================
   TREE VIEW ELEMENTS
   ============================================================================= */

.ygtvlabel {
    color: ${text_color} !important;
    text-decoration: none !important;
    padding: 2px 4px !important;
    border-radius: 3px !important;
}

.ygtvlabel:hover {
    background-color: ${light_bg} !important;
    color: ${primary_color} !important;
}

.ygtvfocus {
    background-color: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 3px !important;
}

/* =============================================================================
   MISCELLANEOUS ELEMENTS
   ============================================================================= */

a {
    color: ${primary_color} !important;
    transition: color 0.3s ease !important;
}

a:hover {
    color: ${secondary_color} !important;
    text-decoration: underline !important;
}

a:visited {
    color: ${tertiary_color} !important;
}

.panel, .card {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1) !important;
}

.panel-heading, .card-header {
    background: ${light_bg} !important;
    border-bottom: 1px solid rgba(0,0,0,0.1) !important;
    color: ${primary_color} !important;
    font-weight: 600 !important;
    padding: 12px 16px !important;
}

.sidebar, .left-sidebar {
    background-color: ${light_bg} !important;
    border-right: 2px solid rgba(0,0,0,0.1) !important;
}

.badge, .label {
    background-color: ${primary_color} !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    padding: 4px 8px !important;
    border-radius: 12px !important;
    font-size: 12px !important;
}

.yui-skin-sam .yui-ac-content {
    background: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 0 0 6px 6px !important;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
}

.yui-skin-sam .yui-ac-content li.yui-ac-prehighlight {
    background: ${light_bg} !important;
}

.yui-skin-sam .yui-ac-content li.yui-ac-highlight {
    background: ${primary_color} !important;
    color: #ffffff !important;
}

::-webkit-scrollbar {
    width: 12px !important;
    height: 12px !important;
}

::-webkit-scrollbar-track {
    background: ${light_bg} !important;
    border-radius: 6px !important;
}

::-webkit-scrollbar-thumb {
    background: rgba(0,0,0,0.2) !important;
    border-radius: 6px !important;
}

::-webkit-scrollbar-thumb:hover {
    background: rgba(0,0,0,0.3) !important;
}
EOF
}

# Update all themes
print_info "Updating themes with comprehensive XNAT styling..."

# Sunset Orange
print_info "Updating Sunset Orange theme..."
generate_theme_css "sunset-orange" "#cc4400" "#e55722" "#993300" "#fdf8f3" "#2c3e50" "Sunset Orange Theme for XNAT - Warm, energetic theme with sunset-inspired gradients"
print_success "Updated Sunset Orange theme"

# Royal Purple  
print_info "Updating Royal Purple theme..."
generate_theme_css "royal-purple" "#663399" "#7a4bb8" "#4d2670" "#faf9fc" "#2c3e50" "Royal Purple Theme for XNAT - Elegant, sophisticated purple theme with luxurious gradients"
print_success "Updated Royal Purple theme"

# Midnight Dark
print_info "Updating Midnight Dark theme..."
generate_theme_css "midnight-dark" "#2c2c54" "#40407a" "#3a3a6b" "#1a1a1a" "#e0e0e0" "Midnight Dark Theme for XNAT - Modern dark theme with high contrast and blue accents"
print_success "Updated Midnight Dark theme"

# Coral Reef
print_info "Updating Coral Reef theme..."
generate_theme_css "coral-reef" "#ff6b6b" "#ff8e8e" "#ee5a52" "#fef9f8" "#2c3e50" "Coral Reef Theme for XNAT - Vibrant coral and teal theme inspired by tropical reefs"
print_success "Updated Coral Reef theme"

# Arctic Frost
print_info "Updating Arctic Frost theme..."
generate_theme_css "arctic-frost" "#718096" "#a0aec0" "#4a5568" "#f8fafb" "#2c3e50" "Arctic Frost Theme for XNAT - Clean, minimalist theme with cool blues and whites"
print_success "Updated Arctic Frost theme"

# Golden Wheat
print_info "Updating Golden Wheat theme..."
generate_theme_css "golden-wheat" "#d69e2e" "#ecc94b" "#b7791f" "#fffcf7" "#2c3e50" "Golden Wheat Theme for XNAT - Warm, earthy theme with golden yellows and rich browns"
print_success "Updated Golden Wheat theme"

# Electric Lime
print_info "Updating Electric Lime theme..."
generate_theme_css "electric-lime" "#84cc16" "#a3e635" "#65a30d" "#f7ffef" "#2c3e50" "Electric Lime Theme for XNAT - High-energy theme with vibrant greens and electric accents"
print_success "Updated Electric Lime theme"

# Crimson Red
print_info "Updating Crimson Red theme..."
generate_theme_css "crimson-red" "#dc2626" "#ef4444" "#b91c1c" "#fefbfb" "#2c3e50" "Crimson Red Theme for XNAT - Bold, powerful theme with deep reds and elegant contrasts"
print_success "Updated Crimson Red theme"

print_success "All themes updated with comprehensive XNAT element styling!"
print_info "Run ./package-themes.sh to re-package the updated themes"
EOF