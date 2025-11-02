# Repository Structure

## Recommended Directory Layout

```
xrpl-rippled-watch/
├── README.md                   # Main documentation
├── LICENSE                     # MIT License
├── CHANGELOG.md               # Version history
├── CONTRIBUTING.md            # Contribution guidelines
├── .gitignore                 # Git ignore rules
│
├── rippled-watch.sh          # Main monitoring script (executable)
├── install.sh                # System-wide installation script
├── uninstall.sh              # Uninstallation script
│
├── images/                   # Screenshots and diagrams
│   └── rippled-watch-preview.png
│
├── docs/                     # Additional documentation (optional)
│   ├── ARCHITECTURE.md       # Technical architecture details
│   ├── API.md               # RPC API documentation
│   └── TROUBLESHOOTING.md   # Extended troubleshooting guide
│
└── examples/                 # Example configurations (optional)
    ├── docker-deployment.conf
    └── native-deployment.conf
```

## File Descriptions

### Root Files

- **README.md** - Primary documentation with installation, usage, and troubleshooting
- **LICENSE** - MIT License for the project
- **CHANGELOG.md** - Version history and release notes
- **CONTRIBUTING.md** - Guidelines for contributors
- **.gitignore** - Files and patterns to exclude from git

### Executable Scripts

- **rippled-watch.sh** - Main monitoring script
  - Should be executable (`chmod +x`)
  - Can be run from any location
  - Creates config file in script directory

- **install.sh** - Installation script
  - Installs script system-wide to `/usr/local/bin`
  - Checks dependencies
  - Creates uninstaller
  - Requires sudo/root

- **uninstall.sh** - Uninstallation script
  - Removes system-wide installation
  - Preserves user config files
  - Requires sudo/root

### Images Directory

- **rippled-watch-preview.png** - Screenshot of monitor in action
  - Should show typical running state
  - Include all major sections
  - Clear, readable terminal output

### Optional: docs/ Directory

Additional detailed documentation (if README becomes too large):

- **ARCHITECTURE.md** - Technical deep dive
  - Code organization
  - Function reference
  - Extension points

- **API.md** - rippled RPC API reference
  - Endpoint descriptions
  - Response formats
  - Example calls

- **TROUBLESHOOTING.md** - Extended troubleshooting
  - Common issues database
  - Debug procedures
  - FAQ

### Optional: examples/ Directory

Example configuration files for reference:

- **docker-deployment.conf** - Example Docker config
- **native-deployment.conf** - Example native config

## Creating the Repository

### Step 1: Initialize Repository

```bash
mkdir xrpl-rippled-watch
cd xrpl-rippled-watch
git init
```

### Step 2: Add Files

```bash
# Copy your scripts
cp /path/to/rippled-watch.sh .
chmod +x rippled-watch.sh

# Copy documentation files (from artifacts)
# - README.md
# - LICENSE
# - CHANGELOG.md
# - CONTRIBUTING.md
# - .gitignore

# Copy installer/uninstaller
cp /path/to/install.sh .
cp /path/to/uninstall.sh .
chmod +x install.sh uninstall.sh
```

### Step 3: Create Images Directory

```bash
mkdir images
# Add your screenshot
cp /path/to/screenshot.png images/rippled-watch-preview.png
```

### Step 4: Initial Commit

```bash
git add .
git commit -m "Initial commit: XRPL Validator Health Monitor v1.0.0"
```

### Step 5: Create GitHub Repository

```bash
# On GitHub, create new repository: xrpl-rippled-watch
# Then link and push:

git remote add origin https://github.com/YOUR_USERNAME/xrpl-rippled-watch.git
git branch -M main
git push -u origin main
```

### Step 6: Create Release

On GitHub:
1. Go to "Releases" → "Create a new release"
2. Tag: `v1.0.0`
3. Title: `XRPL Validator Health Monitor v1.0.0`
4. Description: Copy from CHANGELOG.md
5. Attach: `rippled-watch.sh` as binary asset
6. Publish release

## Maintaining the Repository

### For New Features

```bash
git checkout -b feature/my-feature
# Make changes
git add .
git commit -m "feat: add new feature"
git push origin feature/my-feature
# Create pull request on GitHub
```

### For Bug Fixes

```bash
git checkout -b fix/bug-description
# Make changes
git add .
git commit -m "fix: resolve bug description"
git push origin fix/bug-description
# Create pull request on GitHub
```

### For New Releases

1. Update CHANGELOG.md with new version
2. Update version references in scripts (if applicable)
3. Commit changes
4. Create git tag: `git tag -a v1.1.0 -m "Release v1.1.0"`
5. Push tag: `git push origin v1.1.0`
6. Create GitHub release from tag

## Repository Settings

### Recommended GitHub Settings

**Repository Settings:**
- Description: "Lightweight real-time monitoring for XRPL validator nodes"
- Topics: `xrpl`, `rippled`, `validator`, `monitoring`, `bash`, `devops`, `cryptocurrency`
- Include: README, License, .gitignore

**Branch Protection:**
- Require pull request reviews before merging
- Require status checks to pass

**Labels:**
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Documentation improvements
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed

## Documentation Updates

When updating docs:
1. Keep README.md as primary source
2. Move detailed content to docs/ if README grows too large
3. Update CHANGELOG.md for every release
4. Keep screenshot up to date with UI changes
5. Update version numbers consistently across all files

## File Permissions

After cloning, ensure proper permissions:

```bash
chmod +x rippled-watch.sh
chmod +x install.sh
chmod +x uninstall.sh
```

## Excluded from Git

These files are in .gitignore and should not be committed:
- `*.conf` - User configuration files
- `*.log` - Log files
- `*~`, `*.swp` - Editor backup files
- `.DS_Store` - macOS system files

Users will generate their own config files when running the script.
