#!/usr/bin/env bash
# XRPL Validator Health Monitor - Installation Script
# This script installs rippled-watch system-wide

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Installation paths
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="rippled-watch"
SOURCE_SCRIPT="rippled-watch.sh"

# Backup location for rollback
BACKUP_DIR="/tmp/rippled-watch-backup-$(date +%s)"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  XRPL Validator Health Monitor - Installer          ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}✗ This script must be run as root or with sudo${NC}"
    echo "  Usage: sudo ./install.sh"
    exit 1
fi

echo -e "${GREEN}✓${NC} Running with appropriate permissions"

# Check if source script exists
if [ ! -f "$SOURCE_SCRIPT" ]; then
    echo -e "${RED}✗ Source script not found: $SOURCE_SCRIPT${NC}"
    echo "  Please run this installer from the xrpl-rippled-watch directory"
    exit 1
fi

echo -e "${GREEN}✓${NC} Source script found: $SOURCE_SCRIPT"

# Check for required dependencies
echo
echo "Checking dependencies..."

MISSING_DEPS=()

if ! command -v jq >/dev/null 2>&1; then
    MISSING_DEPS+=("jq")
fi

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo -e "${YELLOW}⚠${NC} Missing dependencies: ${MISSING_DEPS[*]}"
    echo
    read -p "Would you like to install missing dependencies? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        echo "Installing dependencies..."
        if command -v apt-get >/dev/null 2>&1; then
            apt-get update
            apt-get install -y "${MISSING_DEPS[@]}"
        elif command -v yum >/dev/null 2>&1; then
            yum install -y "${MISSING_DEPS[@]}"
        else
            echo -e "${RED}✗ Could not determine package manager${NC}"
            echo "  Please install manually: ${MISSING_DEPS[*]}"
            exit 1
        fi
        echo -e "${GREEN}✓${NC} Dependencies installed"
    else
        echo -e "${RED}✗ Installation cancelled${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓${NC} All dependencies satisfied"
fi

# Create backup if existing installation
if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    echo
    echo -e "${YELLOW}⚠${NC} Existing installation found"
    mkdir -p "$BACKUP_DIR"
    cp "$INSTALL_DIR/$SCRIPT_NAME" "$BACKUP_DIR/"
    echo -e "${GREEN}✓${NC} Backup created: $BACKUP_DIR/$SCRIPT_NAME"
fi

# Install the script
echo
echo "Installing to $INSTALL_DIR/$SCRIPT_NAME..."

cp "$SOURCE_SCRIPT" "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo -e "${GREEN}✓${NC} Script installed successfully"

# Verify installation
if [ -x "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    echo -e "${GREEN}✓${NC} Installation verified"
else
    echo -e "${RED}✗ Installation verification failed${NC}"
    exit 1
fi

# Check if directory is in PATH
if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then
    echo -e "${GREEN}✓${NC} $INSTALL_DIR is in PATH"
else
    echo -e "${YELLOW}⚠${NC} $INSTALL_DIR is not in PATH"
    echo "  You may need to add it to your shell configuration"
fi

# Create uninstall script
UNINSTALL_SCRIPT="$INSTALL_DIR/${SCRIPT_NAME}-uninstall"
cat > "$UNINSTALL_SCRIPT" << 'EOF'
#!/usr/bin/env bash
# XRPL Validator Health Monitor - Uninstaller

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}✗ This script must be run as root or with sudo${NC}"
    exit 1
fi

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="rippled-watch"

echo -e "${YELLOW}Uninstalling XRPL Validator Health Monitor...${NC}"
echo

if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    rm -f "$INSTALL_DIR/$SCRIPT_NAME"
    echo -e "${GREEN}✓${NC} Removed $INSTALL_DIR/$SCRIPT_NAME"
else
    echo -e "${YELLOW}⚠${NC} Script not found at $INSTALL_DIR/$SCRIPT_NAME"
fi

# Remove self
rm -f "$INSTALL_DIR/${SCRIPT_NAME}-uninstall"
echo -e "${GREEN}✓${NC} Removed uninstaller"

echo
echo -e "${GREEN}✓${NC} Uninstallation complete"
echo
echo "Note: User configuration files were not removed."
echo "To remove config files, run: find ~ -name 'rippled-watch.conf' -delete"
EOF

chmod +x "$UNINSTALL_SCRIPT"
echo -e "${GREEN}✓${NC} Created uninstaller: $UNINSTALL_SCRIPT"

# Installation summary
echo
echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  Installation Complete!                              ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${GREEN}✓${NC} rippled-watch installed to: $INSTALL_DIR/$SCRIPT_NAME"
echo -e "${GREEN}✓${NC} Uninstaller created: $UNINSTALL_SCRIPT"
if [ -d "$BACKUP_DIR" ]; then
    echo -e "${GREEN}✓${NC} Backup saved: $BACKUP_DIR"
fi
echo
echo "Usage:"
echo "  Run monitor:  $SCRIPT_NAME"
echo "  Show help:    $SCRIPT_NAME --help"
echo "  Reconfigure:  $SCRIPT_NAME --reconfig"
echo "  Uninstall:    sudo ${SCRIPT_NAME}-uninstall"
echo
echo "Get started:"
echo "  $ $SCRIPT_NAME"
echo
