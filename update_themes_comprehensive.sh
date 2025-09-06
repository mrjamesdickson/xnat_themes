#!/bin/bash

# XNAT Theme Comprehensive Update Script with XNAT Web-specific Elements
# This script updates all themes with complete XNAT and YUI element styling

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

# Function to generate comprehensive theme CSS with XNAT web-specific elements
generate_comprehensive_theme_css() {
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
 * Comprehensive styling for all XNAT UI elements including YUI and XNAT-specific components
 */

/* =============================================================================
   CSS CUSTOM PROPERTIES (BRAND VARIABLES)
   ============================================================================= */

:root {
    --XNAT-blue-500: ${primary_color} !important;
    --XNAT-blue-600: ${tertiary_color} !important;
    --XNAT-gray-300: rgba(0,0,0,0.1) !important;
    --XNAT-gray-100: ${light_bg} !important;
    --link-color: ${primary_color} !important;
    --primary-button-bg: ${primary_color} !important;
    --default-border: rgba(0,0,0,0.1) !important;
}

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

body.popup, body.modal-popup {
    background-color: #ffffff !important;
    color: ${text_color} !important;
}

/* =============================================================================
   NAVIGATION & LAYOUT COMPONENTS
   ============================================================================= */

/* Main Navigation */
#main_nav {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border-bottom: 3px solid ${tertiary_color} !important;
}

#main_nav ul.nav {
    background: transparent !important;
}

#main_nav ul.nav > li > a {
    color: #ffffff !important;
    font-weight: 500 !important;
    transition: background-color 0.3s ease !important;
}

#main_nav ul.nav > li > a:hover,
#main_nav ul.nav > li.active > a {
    background-color: rgba(255, 255, 255, 0.2) !important;
    color: rgba(255, 255, 255, 0.9) !important;
}

#main_nav ul.nav li li {
    background-color: ${light_bg} !important;
    border-top: 1px solid rgba(0,0,0,0.1) !important;
}

#main_nav ul.nav li li a {
    color: ${primary_color} !important;
    padding: 8px 16px !important;
}

#main_nav ul.nav li li a:hover {
    background-color: rgba(0,0,0,0.05) !important;
    color: ${secondary_color} !important;
}

/* Breadcrumbs */
#breadcrumbs {
    background-color: ${light_bg} !important;
    border-bottom: 1px solid rgba(0,0,0,0.1) !important;
    padding: 8px 16px !important;
}

#breadcrumbs a {
    color: ${primary_color} !important;
    text-decoration: none !important;
}

#breadcrumbs a:hover {
    color: ${secondary_color} !important;
    text-decoration: underline !important;
}

#breadcrumbs a.last {
    color: ${text_color} !important;
    font-weight: 600 !important;
}

/* Page Layout */
#layout_content {
    background-color: #ffffff !important;
    min-height: calc(100vh - 200px) !important;
}

#page_wrapper {
    background-color: ${light_bg} !important;
}

.leftBar {
    background-color: ${light_bg} !important;
    border-right: 2px solid rgba(0,0,0,0.1) !important;
}

#xnat_power {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    text-align: center !important;
    padding: 10px !important;
}

/* =============================================================================
   XNAT NAVIGATION TABS
   ============================================================================= */

.xnat-nav-tabs {
    border-bottom: 5px solid ${primary_color} !important;
    background: ${light_bg} !important;
    margin-bottom: 0 !important;
}

.xnat-nav-tabs li.tab {
    background: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-bottom: none !important;
    margin-right: 2px !important;
    border-radius: 6px 6px 0 0 !important;
}

.xnat-nav-tabs li.tab > a {
    color: ${primary_color} !important;
    font-weight: 500 !important;
    padding: 12px 20px !important;
    text-decoration: none !important;
    display: block !important;
}

.xnat-nav-tabs li.tab:hover {
    background-color: rgba(0,0,0,0.05) !important;
}

.xnat-nav-tabs li.tab.active {
    background: ${primary_color} !important;
    border-color: ${tertiary_color} !important;
}

.xnat-nav-tabs li.tab.active > a {
    color: #ffffff !important;
}

.xnat-tab-content {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-top: none !important;
    padding: 20px !important;
    min-height: 400px !important;
}

.xnat-tab-content .tab-pane {
    background: transparent !important;
}

/* =============================================================================
   YUI FRAMEWORK COMPONENTS (Enhanced from previous version)
   ============================================================================= */

/* YUI Navigation */
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

.yui-skin-sam .yui-navset .yui-nav .selected {
    background: ${primary_color} !important;
    border-color: ${tertiary_color} !important;
}

.yui-skin-sam .yui-navset .yui-nav .selected a {
    color: #ffffff !important;
}

.yui-skin-sam .yui-navset .yui-content {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-top: none !important;
    padding: 20px !important;
}

/* YUI Buttons */
.yui-skin-sam .yui-button {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border: 1px solid ${tertiary_color} !important;
    border-radius: 4px !important;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2) !important;
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

/* YUI Dialogs */
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

/* =============================================================================
   DATA DISPLAY COMPONENTS
   ============================================================================= */

/* XNAT Data Tables */
.xnat-table,
.data-table-wrapper table {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-collapse: separate !important;
    border-spacing: 0 !important;
    width: 100% !important;
}

.xnat-table thead th,
.data-table-wrapper table thead th {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    padding: 12px 8px !important;
    border-right: 1px solid rgba(255, 255, 255, 0.3) !important;
    text-align: left !important;
}

.xnat-table tbody tr,
.data-table-wrapper table tbody tr {
    transition: background-color 0.2s ease !important;
}

.xnat-table tbody tr:nth-child(even),
.data-table-wrapper table tbody tr:nth-child(even) {
    background-color: rgba(0,0,0,0.02) !important;
}

.xnat-table tbody tr:hover,
.xnat-table.highlight tbody tr:hover,
.data-table-wrapper table tbody tr:hover {
    background-color: ${light_bg} !important;
}

.xnat-table tbody td,
.data-table-wrapper table tbody td {
    padding: 10px 8px !important;
    border-bottom: 1px solid rgba(0,0,0,0.05) !important;
}

/* Filter Components */
.xnat-table.data-table tr.filter {
    background: ${light_bg} !important;
    border-top: 2px solid ${primary_color} !important;
}

.xnat-table.data-table .filter > input {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.2) !important;
    border-radius: 3px !important;
    padding: 4px 8px !important;
    font-size: 12px !important;
    width: 100% !important;
}

.xnat-table.data-table .filter > input:focus {
    border-color: ${primary_color} !important;
    box-shadow: 0 0 3px rgba(0,0,0,0.2) !important;
}

.filter-submit {
    background: ${primary_color} !important;
    color: #ffffff !important;
    border: 1px solid ${tertiary_color} !important;
    padding: 6px 12px !important;
    border-radius: 4px !important;
    cursor: pointer !important;
}

.filter-submit:hover {
    background: ${secondary_color} !important;
}

/* Data Table Loading */
.data-table-wrapper.loading {
    position: relative !important;
    opacity: 0.6 !important;
}

.data-table-wrapper.loading::after {
    content: "Loading..." !important;
    position: absolute !important;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%) !important;
    background: ${primary_color} !important;
    color: #ffffff !important;
    padding: 10px 20px !important;
    border-radius: 4px !important;
    font-weight: 600 !important;
}

/* =============================================================================
   BOOTSTRAP INTEGRATION
   ============================================================================= */

.xnat-bootstrap .btn {
    font-weight: 500 !important;
    border-radius: 4px !important;
    padding: 8px 16px !important;
    transition: all 0.3s ease !important;
}

.xnat-bootstrap .btn-primary {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border-color: ${tertiary_color} !important;
    color: #ffffff !important;
}

.xnat-bootstrap .btn-primary:hover {
    background: linear-gradient(135deg, ${secondary_color}, ${tertiary_color}) !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3) !important;
}

.xnat-bootstrap .btn-secondary {
    background-color: #6c757d !important;
    border-color: #5a6268 !important;
    color: #ffffff !important;
}

.xnat-bootstrap .btn-danger {
    background: linear-gradient(135deg, #dc3545, #c82333) !important;
    border-color: #bd2130 !important;
    color: #ffffff !important;
}

.xnat-bootstrap .btn-success {
    background: linear-gradient(135deg, #28a745, #20c997) !important;
    border-color: #1e7e34 !important;
    color: #ffffff !important;
}

.xnat-bootstrap .form-group {
    margin-bottom: 1rem !important;
}

.xnat-bootstrap .form-check-input {
    margin-right: 8px !important;
    transform: scale(1.2) !important;
}

.xnat-bootstrap .wizard-page {
    background-color: #ffffff !important;
    padding: 20px !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1) !important;
}

/* =============================================================================
   MODAL DIALOGS & POPUPS
   ============================================================================= */

.xmodal,
.xnat-dialog-shell {
    background-color: rgba(0,0,0,0.5) !important;
    backdrop-filter: blur(2px) !important;
}

.xmodal.xnat-bootstrap {
    color: ${text_color} !important;
}

.xnat-dialog-content {
    background-color: #ffffff !important;
    border-radius: 8px !important;
    box-shadow: 0 4px 20px rgba(0,0,0,0.15) !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
}

/* =============================================================================
   ALERT & NOTIFICATION COMPONENTS
   ============================================================================= */

.xnat-bootstrap div.alert {
    border-radius: 6px !important;
    padding: 12px 16px !important;
    margin: 8px 0 !important;
    font-weight: 500 !important;
}

.xnat-bootstrap div.alert.alert-info {
    background-color: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    color: ${primary_color} !important;
}

.xnat-bootstrap div.alert.alert-danger,
.xnat-bootstrap div.error {
    background-color: #f8d7da !important;
    border: 1px solid #f5c6cb !important;
    color: #721c24 !important;
}

.xnat-bootstrap div.warning {
    background-color: #fff3cd !important;
    border: 1px solid #ffeaa7 !important;
    color: #856404 !important;
}

.xnat-bootstrap div.success {
    background-color: #d4edda !important;
    border: 1px solid #c3e6cb !important;
    color: #155724 !important;
}

/* Form.io Integration */
.formio-form {
    background-color: #ffffff !important;
    padding: 20px !important;
    border-radius: 8px !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
}

.formio-error-wrapper {
    margin-top: 5px !important;
}

.formio-errors .error {
    background-color: #f8d7da !important;
    color: #721c24 !important;
    padding: 8px 12px !important;
    border-radius: 4px !important;
    font-size: 14px !important;
    border: 1px solid #f5c6cb !important;
}

.formio-read-only {
    background-color: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    padding: 15px !important;
    border-radius: 4px !important;
}

/* =============================================================================
   ADMIN PANEL COMPONENTS
   ============================================================================= */

.admin-content {
    background-color: #ffffff !important;
    border-radius: 8px !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    margin: 10px 0 !important;
}

.admin-content .header {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    padding: 15px 20px !important;
    font-weight: 600 !important;
    border-radius: 8px 8px 0 0 !important;
    border-bottom: 1px solid ${tertiary_color} !important;
}

.admin-content .data-table {
    margin: 0 !important;
    border: none !important;
}

.settings-tabs {
    border-bottom: 3px solid ${primary_color} !important;
    background: ${light_bg} !important;
}

.settings-tabs li {
    background: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-bottom: none !important;
    margin-right: 2px !important;
}

.settings-tabs li a {
    color: ${primary_color} !important;
    padding: 10px 16px !important;
    text-decoration: none !important;
    display: block !important;
}

.settings-tabs li.active {
    background: ${primary_color} !important;
}

.settings-tabs li.active a {
    color: #ffffff !important;
}

/* =============================================================================
   FILE MANAGEMENT & UPLOAD COMPONENTS
   ============================================================================= */

table.file-details {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-collapse: collapse !important;
    width: 100% !important;
}

table.file-details th {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    padding: 10px 8px !important;
    font-weight: 600 !important;
}

table.file-details td {
    padding: 8px !important;
    border-bottom: 1px solid rgba(0,0,0,0.05) !important;
}

table.file-details td.scan-image-link a {
    color: ${primary_color} !important;
    text-decoration: none !important;
    font-weight: 500 !important;
}

table.file-details td.scan-image-link a:hover {
    color: ${secondary_color} !important;
    text-decoration: underline !important;
}

table.file-details td.scan-image-buttons {
    text-align: right !important;
}

table.file-details td.scan-image-buttons button {
    background: ${primary_color} !important;
    color: #ffffff !important;
    border: 1px solid ${tertiary_color} !important;
    padding: 4px 8px !important;
    margin: 0 2px !important;
    border-radius: 3px !important;
    cursor: pointer !important;
}

table.file-details td.scan-image-buttons button:hover {
    background: ${secondary_color} !important;
}

.upload-complete {
    background-color: #d4edda !important;
    color: #155724 !important;
    padding: 10px 15px !important;
    border: 1px solid #c3e6cb !important;
    border-radius: 4px !important;
    margin: 10px 0 !important;
}

.upload-prog {
    background: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 4px !important;
    padding: 10px !important;
    margin: 10px 0 !important;
}

.upload-prog .progress-bar {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    height: 20px !important;
    border-radius: 10px !important;
    transition: width 0.3s ease !important;
}

/* Scan-Specific Elements */
#scan_list .scan-details {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 6px !important;
    margin: 10px 0 !important;
    padding: 15px !important;
}

.scan-details-table {
    background-color: #ffffff !important;
    width: 100% !important;
}

.scan-details-table th {
    background: ${light_bg} !important;
    color: ${primary_color} !important;
    padding: 8px !important;
    font-weight: 600 !important;
    text-align: left !important;
}

.scan-details-table td {
    padding: 6px 8px !important;
    border-bottom: 1px solid rgba(0,0,0,0.05) !important;
}

img.scan-snapshot {
    border: 2px solid rgba(0,0,0,0.1) !important;
    border-radius: 4px !important;
    max-width: 150px !important;
    height: auto !important;
    cursor: pointer !important;
    transition: transform 0.2s ease !important;
}

img.scan-snapshot:hover {
    transform: scale(1.05) !important;
    border-color: ${primary_color} !important;
}

/* =============================================================================
   PROGRESS & LOADING INDICATORS
   ============================================================================= */

.xnat-bootstrap .progress {
    background-color: ${light_bg} !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 10px !important;
    height: 20px !important;
    overflow: hidden !important;
}

.xnat-bootstrap .progress-bar {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    color: #ffffff !important;
    text-align: center !important;
    line-height: 20px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    transition: width 0.3s ease !important;
}

.xnat-bootstrap .progress-bar-striped {
    background-image: linear-gradient(45deg, rgba(255,255,255,.15) 25%, transparent 25%, transparent 50%, rgba(255,255,255,.15) 50%, rgba(255,255,255,.15) 75%, transparent 75%, transparent) !important;
    background-size: 1rem 1rem !important;
    animation: progress-bar-stripes 1s linear infinite !important;
}

@keyframes progress-bar-stripes {
    0% { background-position: 1rem 0; }
    100% { background-position: 0 0; }
}

/* =============================================================================
   SEARCH & FILTER COMPONENTS
   ============================================================================= */

form.search-wizard {
    background-color: #ffffff !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
    padding: 20px !important;
    margin: 10px 0 !important;
}

.advanced-search-fields {
    background: ${light_bg} !important;
    border-radius: 6px !important;
    padding: 15px !important;
    margin: 15px 0 !important;
}

.advanced-search-fields .search-group {
    margin-bottom: 15px !important;
    padding: 10px !important;
    border: 1px solid rgba(0,0,0,0.1) !important;
    border-radius: 4px !important;
    background-color: #ffffff !important;
}

.advanced-search-fields .search-item {
    display: flex !important;
    align-items: center !important;
    margin-bottom: 10px !important;
}

.advanced-search-fields .search-item label {
    color: ${primary_color} !important;
    font-weight: 500 !important;
    margin-right: 10px !important;
    min-width: 120px !important;
}

.advanced-search-fields .search-item input,
.advanced-search-fields .search-item select {
    border: 1px solid rgba(0,0,0,0.2) !important;
    border-radius: 4px !important;
    padding: 6px 10px !important;
    font-size: 14px !important;
    flex: 1 !important;
}

.advanced-search-fields .search-item input:focus,
.advanced-search-fields .search-item select:focus {
    border-color: ${primary_color} !important;
    box-shadow: 0 0 5px rgba(0,0,0,0.2) !important;
}

label.search-method-label {
    color: ${primary_color} !important;
    font-weight: 600 !important;
    font-size: 16px !important;
    margin-bottom: 10px !important;
    display: block !important;
}

/* =============================================================================
   ICON SYSTEM
   ============================================================================= */

.icon-add, .icon-edit, .icon-delete,
.icon-check-green, .icon-check-blue,
.icon-arrow-right, .icon-arrow-left,
.icon-caret-up, .icon-caret-down {
    display: inline-block !important;
    width: 16px !important;
    height: 16px !important;
    vertical-align: middle !important;
    margin: 0 4px !important;
}

.icon-add {
    background-color: #28a745 !important;
    border-radius: 50% !important;
}

.icon-edit {
    background-color: ${primary_color} !important;
    border-radius: 3px !important;
}

.icon-delete {
    background-color: #dc3545 !important;
    border-radius: 3px !important;
}

.icon-check-green {
    background-color: #28a745 !important;
    border-radius: 50% !important;
}

.icon-check-blue {
    background-color: ${primary_color} !important;
    border-radius: 50% !important;
}

/* =============================================================================
   UTILITY CLASSES
   ============================================================================= */

.highlight-row {
    background-color: ${light_bg} !important;
    border-left: 4px solid ${primary_color} !important;
}

.off-canvas, .off-screen {
    position: absolute !important;
    left: -9999px !important;
    top: -9999px !important;
}

.shadowed {
    box-shadow: 0 2px 8px rgba(0,0,0,0.1) !important;
}

/* =============================================================================
   FORM ELEMENTS (Enhanced)
   ============================================================================= */

input[type="text"], input[type="password"], input[type="email"], 
input[type="number"], input[type="search"], input[type="tel"],
input[type="url"], input[type="date"], input[type="time"],
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
input[type="url"]:focus, input[type="date"]:focus, input[type="time"]:focus,
select:focus, textarea:focus {
    border-color: ${primary_color} !important;
    box-shadow: 0 0 8px rgba(0,0,0,0.1) !important;
    outline: none !important;
}

button, input[type="submit"], input[type="button"] {
    background: linear-gradient(135deg, ${primary_color}, ${secondary_color}) !important;
    border: 1px solid ${tertiary_color} !important;
    color: #ffffff !important;
    font-weight: 500 !important;
    padding: 8px 16px !important;
    border-radius: 4px !important;
    cursor: pointer !important;
    transition: all 0.3s ease !important;
}

button:hover, input[type="submit"]:hover, input[type="button"]:hover {
    background: linear-gradient(135deg, ${secondary_color}, ${tertiary_color}) !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3) !important;
}

label {
    color: ${text_color} !important;
    font-weight: 500 !important;
    margin-bottom: 4px !important;
    display: inline-block !important;
}

/* =============================================================================
   LINKS & TYPOGRAPHY
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

h1, h2, h3, h4, h5, h6 {
    color: ${primary_color} !important;
    font-weight: 600 !important;
}

/* =============================================================================
   SCROLLBARS
   ============================================================================= */

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

# Update all themes with comprehensive XNAT styling
print_info "Updating themes with comprehensive XNAT and YUI styling..."

# Ocean Blue (already comprehensive, update with additional XNAT elements)
print_info "Updating Ocean Blue theme..."
generate_comprehensive_theme_css "ocean-blue" "#0066cc" "#0052a3" "#003366" "#f0f8ff" "#333333" "Ocean Blue Theme for XNAT - Cool, professional blue theme with ocean-inspired gradients"
print_success "Updated Ocean Blue theme with comprehensive XNAT styling"

# Forest Green
print_info "Updating Forest Green theme..."
generate_comprehensive_theme_css "forest-green" "#2d5016" "#3e6b1f" "#1a3009" "#f5f9f5" "#2c3e50" "Forest Green Theme for XNAT - Natural, calming green theme with earthy tones"
print_success "Updated Forest Green theme with comprehensive XNAT styling"

# Sunset Orange  
print_info "Updating Sunset Orange theme..."
generate_comprehensive_theme_css "sunset-orange" "#cc4400" "#e55722" "#993300" "#fdf8f3" "#2c3e50" "Sunset Orange Theme for XNAT - Warm, energetic theme with sunset-inspired gradients"
print_success "Updated Sunset Orange theme with comprehensive XNAT styling"

# Royal Purple  
print_info "Updating Royal Purple theme..."
generate_comprehensive_theme_css "royal-purple" "#663399" "#7a4bb8" "#4d2670" "#faf9fc" "#2c3e50" "Royal Purple Theme for XNAT - Elegant, sophisticated purple theme with luxurious gradients"
print_success "Updated Royal Purple theme with comprehensive XNAT styling"

# Midnight Dark
print_info "Updating Midnight Dark theme..."
generate_comprehensive_theme_css "midnight-dark" "#2c2c54" "#40407a" "#3a3a6b" "#1a1a1a" "#e0e0e0" "Midnight Dark Theme for XNAT - Modern dark theme with high contrast and blue accents"
print_success "Updated Midnight Dark theme with comprehensive XNAT styling"

# Coral Reef
print_info "Updating Coral Reef theme..."
generate_comprehensive_theme_css "coral-reef" "#ff6b6b" "#ff8e8e" "#ee5a52" "#fef9f8" "#2c3e50" "Coral Reef Theme for XNAT - Vibrant coral and teal theme inspired by tropical reefs"
print_success "Updated Coral Reef theme with comprehensive XNAT styling"

# Arctic Frost
print_info "Updating Arctic Frost theme..."
generate_comprehensive_theme_css "arctic-frost" "#718096" "#a0aec0" "#4a5568" "#f8fafb" "#2c3e50" "Arctic Frost Theme for XNAT - Clean, minimalist theme with cool blues and whites"
print_success "Updated Arctic Frost theme with comprehensive XNAT styling"

# Golden Wheat
print_info "Updating Golden Wheat theme..."
generate_comprehensive_theme_css "golden-wheat" "#d69e2e" "#ecc94b" "#b7791f" "#fffcf7" "#2c3e50" "Golden Wheat Theme for XNAT - Warm, earthy theme with golden yellows and rich browns"
print_success "Updated Golden Wheat theme with comprehensive XNAT styling"

# Electric Lime
print_info "Updating Electric Lime theme..."
generate_comprehensive_theme_css "electric-lime" "#84cc16" "#a3e635" "#65a30d" "#f7ffef" "#2c3e50" "Electric Lime Theme for XNAT - High-energy theme with vibrant greens and electric accents"
print_success "Updated Electric Lime theme with comprehensive XNAT styling"

# Crimson Red
print_info "Updating Crimson Red theme..."
generate_comprehensive_theme_css "crimson-red" "#dc2626" "#ef4444" "#b91c1c" "#fefbfb" "#2c3e50" "Crimson Red Theme for XNAT - Bold, powerful theme with deep reds and elegant contrasts"
print_success "Updated Crimson Red theme with comprehensive XNAT styling"

print_success "All themes updated with comprehensive XNAT and YUI element styling!"
print_info "Each theme now includes:"
print_info "  • Complete YUI framework component styling"
print_info "  • XNAT-specific navigation and layout elements"
print_info "  • Bootstrap 4 integration styling"
print_info "  • File management and upload components"
print_info "  • Admin panel and configuration interfaces"
print_info "  • Search and filter components"
print_info "  • Icon system and utility classes"
print_info "  • CSS custom properties for brand consistency"
print_info ""
print_info "Run ./package-themes.sh to re-package the updated themes"
EOF