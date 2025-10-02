#!/bin/bash

# XNAT Theme Color-Only Update Script
# This script updates themes by only changing colors to match each theme's palette
# without altering existing CSS structure or layout properties

echo -e "\033[0;34mℹ Updating themes with color-only changes to match theme palettes...\033[0m"

# Define theme directories and their colors
THEMES="ocean-blue forest-green sunset-orange royal-purple midnight-dark coral-reef arctic-frost golden-wheat electric-lime crimson-red"

# Function to get theme colors
get_theme_colors() {
    case "$1" in
        "ocean-blue") echo "primary:#0066cc secondary:#003366 accent:#4d9fff background:#f0f8ff border:rgba(0,102,204,0.2) text:#003366" ;;
        "forest-green") echo "primary:#228B22 secondary:#006400 accent:#32CD32 background:#f0fff0 border:rgba(34,139,34,0.2) text:#006400" ;;
        "sunset-orange") echo "primary:#FF6347 secondary:#CC4125 accent:#FF7F50 background:#fff8f0 border:rgba(255,99,71,0.2) text:#CC4125" ;;
        "royal-purple") echo "primary:#6A0DAD secondary:#4B0082 accent:#9370DB background:#f8f0ff border:rgba(106,13,173,0.2) text:#4B0082" ;;
        "midnight-dark") echo "primary:#4a5568 secondary:#2d3748 accent:#68d391 background:#1a1a1a border:rgba(255,255,255,0.1) text:#e2e8f0" ;;
        "coral-reef") echo "primary:#FF7F7F secondary:#E55555 accent:#FFA07A background:#fff5f5 border:rgba(255,127,127,0.2) text:#E55555" ;;
        "arctic-frost") echo "primary:#87CEEB secondary:#4682B4 accent:#B0E0E6 background:#f0f8ff border:rgba(135,206,235,0.2) text:#4682B4" ;;
        "golden-wheat") echo "primary:#DAA520 secondary:#B8860B accent:#FFD700 background:#fffdf0 border:rgba(218,165,32,0.2) text:#B8860B" ;;
        "electric-lime") echo "primary:#32CD32 secondary:#228B22 accent:#7FFF00 background:#f5fff5 border:rgba(50,205,50,0.2) text:#228B22" ;;
        "crimson-red") echo "primary:#DC143C secondary:#B91C3C accent:#FF6B6B background:#fff0f0 border:rgba(220,20,60,0.2) text:#B91C3C" ;;
        *) echo "" ;;
    esac
}

# Function to extract color values from theme color string
get_color_value() {
    local theme_colors="$1"
    local color_type="$2"
    echo "$theme_colors" | grep -o "${color_type}:[^[:space:]]*" | cut -d':' -f2
}

# Function to update theme colors only
update_theme_colors() {
    local theme_name="$1"
    local theme_dir="$theme_name"
    local css_file="$theme_dir/css/theme.css"
    local colors=$(get_theme_colors "$theme_name")
    
    echo -e "\033[0;34mℹ Updating $theme_name colors...\033[0m"
    
    # Extract colors
    local primary=$(get_color_value "$colors" "primary")
    local secondary=$(get_color_value "$colors" "secondary") 
    local accent=$(get_color_value "$colors" "accent")
    local background=$(get_color_value "$colors" "background")
    local border=$(get_color_value "$colors" "border")
    local text=$(get_color_value "$colors" "text")
    
    # Create the CSS template
    local template_file="/tmp/theme_template_$$.css"
    cat > "$template_file" << 'TEMPLATE'
/**
 * THEME_NAME Theme for XNAT - Color-only modifications
 * Preserves existing XNAT layout and styling while applying theme-specific colors
 */

/* =============================================================================
   THEME COLOR VARIABLES
   ============================================================================= */

:root {
    /* Primary theme colors */
    --theme-primary: PRIMARY_COLOR;
    --theme-secondary: SECONDARY_COLOR;
    --theme-accent: ACCENT_COLOR;
    --theme-background: BACKGROUND_COLOR;
    --theme-border: BORDER_COLOR;
    --theme-text: TEXT_COLOR;

    /* XNAT CSS Variable Overrides */
    --XNAT-blue-500: PRIMARY_COLOR !important;
    --XNAT-blue-600: SECONDARY_COLOR !important;
    --XNAT-blue-300: ACCENT_COLOR !important;
    --XNAT-gray-050: BACKGROUND_COLOR !important;
    --XNAT-gray-100: BACKGROUND_COLOR !important;
    --XNAT-gray-300: BORDER_COLOR !important;
    --link-color: PRIMARY_COLOR !important;
    --link-color-hover: SECONDARY_COLOR !important;
    --primary-button-bg: PRIMARY_COLOR !important;
    --primary-button-border: SECONDARY_COLOR !important;
    --default-border: BORDER_COLOR !important;
    --text-color: TEXT_COLOR !important;
}

/* =============================================================================
   GLOBAL BACKGROUND AND TEXT COLORS
   ============================================================================= */

body,
.xnat-bootstrap,
.yui-skin-sam {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

/* Only target key content areas to preserve existing styling */
.panel-body,
.main-content,
.page-content,
.modal-body,
.tab-pane {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

/* Explicitly preserve YUI and pad classes - DO NOT STYLE */
.yui-nav,
.yui-content,
.yui-navset,
.yui-dt,
.yui-panel,
.yui-dialog,
.yuimenubar,
.yuimenubaritem,
.pad,
[class*="yui-nav"],
[class*="yui-content"],
[class*="pad"] {
    /* Intentionally empty - preserve original XNAT styling */
}

/* Specific overrides for main content areas only */
.container,
.container-fluid,
.panel-body {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

/* Override any inline white backgrounds */
*[style*="background-color: white"],
*[style*="background-color: #fff"],
*[style*="background-color: #ffffff"],
*[style*="background: white"],
*[style*="background: #fff"],
*[style*="background: #ffffff"] {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

/* =============================================================================
   XNAT HEADER AND NAVIGATION COLORS
   ============================================================================= */

/* IMPORTANT: Banner/header section preserved - no styling applied to #header */
/* This preserves the XNAT logo banner section as-is */

/* Navigation bar only - excludes header/banner */
.xnat-nav.navbar {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
}

.xnat-nav.navbar a {
    color: white !important;
}

.xnat-nav.navbar a:hover {
    color: var(--theme-accent) !important;
}

/* =============================================================================
   XNAT ADMIN TABS AND NAVIGATION COLORS
   ============================================================================= */

.xnat-nav-tabs li.tab {
    border-color: var(--theme-border) !important;
}

.xnat-nav-tabs li.tab.active {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
}

.xnat-nav-tabs li.tab.active > a {
    color: var(--theme-text) !important;
}

.xnat-nav-tabs li.tab > a {
    color: var(--theme-text) !important;
}

.xnat-nav-tabs.top li.tab.active > a {
    border-top-color: var(--theme-primary) !important;
}

.xnat-nav-tabs.side li.tab.active > a {
    border-left-color: var(--theme-primary) !important;
}

/* =============================================================================
   PANEL AND CONTENT COLORS
   ============================================================================= */

.panel-default .panel-heading {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
    color: white !important;
}

.panel-default {
    border-color: var(--theme-border) !important;
    background-color: var(--theme-background) !important;
}

.panel-default .panel-body {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

.panel-default .panel-footer {
    background-color: var(--theme-background) !important;
    border-color: var(--theme-border) !important;
    color: var(--theme-text) !important;
}

/* =============================================================================
   BUTTON COLORS
   ============================================================================= */

.btn-primary,
button.btn-primary {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
    color: white !important;
}

.btn-primary:hover,
button.btn-primary:hover {
    background-color: var(--theme-secondary) !important;
    border-color: var(--theme-secondary) !important;
}

/* Bootstrap button overrides */
.xnat-bootstrap .btn-primary {
    background: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
}

.xnat-bootstrap .btn-primary:hover {
    background: var(--theme-secondary) !important;
}

/* =============================================================================
   LINK COLORS
   ============================================================================= */

a,
a:visited {
    color: var(--theme-primary) !important;
}

a:hover,
a:active {
    color: var(--theme-secondary) !important;
}

.xnat-bootstrap a,
.xnat-bootstrap a:visited {
    color: var(--theme-primary) !important;
}

.xnat-bootstrap a:hover,
.xnat-bootstrap a:active {
    color: var(--theme-secondary) !important;
}

/* =============================================================================
   FORM AND INPUT COLORS
   ============================================================================= */

input:focus,
textarea:focus,
select:focus {
    border-color: var(--theme-primary) !important;
    box-shadow: 0 0 0 0.2rem var(--theme-border) !important;
}

/* =============================================================================
   YUI FRAMEWORK COLORS (SELECTIVE - AVOID NAV AND CONTENT)
   ============================================================================= */

/* YUI Navigation Sets - REMOVED to preserve original styling */

/* YUI Data Tables - REMOVED to preserve original styling */

/* YUI Dialogs - REMOVED to preserve original styling */

/* YUI Menus - REMOVED to preserve original styling */

/* =============================================================================
   ALERT AND MESSAGE COLORS
   ============================================================================= */

.alert-info,
.xnat-bootstrap .alert-info {
    background-color: var(--theme-background) !important;
    border-color: var(--theme-border) !important;
    color: var(--theme-text) !important;
}

/* =============================================================================
   TABLE AND DATA DISPLAY COLORS
   ============================================================================= */

th {
    background-color: var(--theme-primary) !important;
    color: white !important;
    border-color: var(--theme-secondary) !important;
}

tr:nth-child(even) {
    background-color: var(--theme-background) !important;
}

tr:hover,
.xnat-table tr.highlight:hover,
.xnat-table.highlight tr:hover,
.xnat-table.striped.highlight tr:hover {
    background-color: var(--theme-accent) !important;
}

#main_nav ul.nav table.data-table tr:hover,
#main_nav ul.nav table.data-table .item:hover {
    background: var(--theme-accent) !important;
}

/* =============================================================================
   PAGINATION COLORS
   ============================================================================= */

.pagination .page-item.active .page-link {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-primary) !important;
}

.xnat-bootstrap .pagination {
    border-bottom-color: var(--theme-primary) !important;
}

/* =============================================================================
   BORDER AND ACCENT COLORS
   ============================================================================= */

.xnat-tab-content {
    border-color: var(--theme-border) !important;
}

.xnat-tab-content.side.pull-right {
    border-color: var(--theme-border) !important;
}

hr {
    border-color: var(--theme-border) !important;
}

/* =============================================================================
   FOCUS AND INTERACTION STATES
   ============================================================================= */

*:focus {
    outline-color: var(--theme-primary) !important;
}

.panel .panel-element.highlighted {
    background-color: var(--theme-background) !important;
    border-color: var(--theme-border) !important;
}

/* =============================================================================
   NAVIGATION COLOR OVERRIDES
   ============================================================================= */

/* Main navigation - color only */
#main_nav {
    background-color: var(--theme-primary) !important;
    border-color: var(--theme-secondary) !important;
}

#main_nav ul.nav > li > a {
    color: white !important;
}

#main_nav ul.nav > li > a:hover,
#main_nav ul.nav > li.active > a {
    background-color: var(--theme-secondary) !important;
}

#main_nav ul.nav li li a:hover {
    background-color: var(--theme-accent) !important;
}

#main_nav ul.nav li li.active,
#main_nav ul.nav li li.active > a,
#main_nav ul.nav li li.active > a:hover {
    background-color: var(--theme-accent) !important;
}

/* Actions menu color enhancements */
#actionsMenu li a:hover,
#actionsMenu li.yuimenuitem-hassubmenu > a:hover {
    background-color: var(--theme-accent) !important;
}

#actionsMenu > .bd > .first-of-type a {
    background: var(--theme-primary) !important;
}

/* Accordion and widget colors */
body #accordion h3.active,
div.download-column h3 {
    background: var(--theme-primary) !important;
    border-color: var(--theme-primary) !important;
}

/* Container title colors */
div.containerTitle.withColor {
    background: var(--theme-primary) !important;
}
TEMPLATE

    # Capitalize first letter of theme name
    local theme_title=$(echo "$theme_name" | sed 's/^./\U&/' | sed 's/-/ /')
    
    # Replace placeholders with actual colors
    sed -e "s/THEME_NAME/$theme_title/g" \
        -e "s/PRIMARY_COLOR/$primary/g" \
        -e "s/SECONDARY_COLOR/$secondary/g" \
        -e "s/ACCENT_COLOR/$accent/g" \
        -e "s/BACKGROUND_COLOR/$background/g" \
        -e "s|BORDER_COLOR|$border|g" \
        -e "s/TEXT_COLOR/$text/g" \
        "$template_file" > "$css_file"
    
    # Add extra aggressive overrides for dark themes
    if [[ "$theme_name" == "midnight-dark" ]]; then
        cat >> "$css_file" << 'DARK_THEME_EXTRA'

/* =============================================================================
   AGGRESSIVE DARK THEME OVERRIDES
   ============================================================================= */

/* Conservative dark theme overrides - preserve gradients and styling */
body,
.content,
.main-content,
.page-content {
    background-color: var(--theme-background) !important;
    color: var(--theme-text) !important;
}

/* Restore necessary white elements */
.btn-primary,
button.btn-primary,
.xnat-nav-tabs li.tab.active > a,
.panel-default .panel-heading,
th {
    color: white !important;
}

/* EXCLUDE YUI elements from dark theme overrides */
.yui-nav,
.yui-content, 
.yui-navset,
.yui-dt,
.yui-panel,
.yui-dialog,
.yuimenubar,
.yuimenubaritem,
.pad,
[class*="yui-nav"],
[class*="yui-content"],
[class*="pad"] {
    background-color: initial !important;
    color: initial !important;
}

/* Conservative navbar styling - preserve header/banner section */
.xnat-nav.navbar a,
.navbar a,
.navbar-nav > li > a {
    color: var(--theme-text) !important;
}

.xnat-nav.navbar a:hover,
.navbar a:hover,
.navbar-nav > li > a:hover {
    color: var(--theme-accent) !important;
}

/* Keep button and interactive element backgrounds */
.btn-primary,
button.btn-primary {
    background-color: var(--theme-primary) !important;
}

.xnat-nav-tabs li.tab.active {
    background-color: var(--theme-primary) !important;
}

/* Text inputs need lighter background for visibility */
input[type="text"],
input[type="email"], 
input[type="password"],
input[type="search"],
textarea,
select {
    background-color: #2d2d2d !important;
    color: var(--theme-text) !important;
    border-color: var(--theme-border) !important;
}

DARK_THEME_EXTRA
    fi
    
    # Clean up temp file
    rm "$template_file"

    echo -e "\033[0;32m✓ Updated $theme_name with color-only changes\033[0m"
}

# Update all themes with color-only changes
for theme in $THEMES; do
    if [ -d "$theme" ]; then
        update_theme_colors "$theme"
    else
        echo -e "\033[0;31m✗ Theme directory not found: $theme\033[0m"
    fi
done

echo -e "\033[0;32m✓ All themes updated with color-only modifications!\033[0m"
echo -e "\033[0;34mℹ Each theme now has colors matching its palette while preserving XNAT structure\033[0m"
echo -e "\033[0;34mℹ Run ./package-themes.sh to package the color-updated themes\033[0m"