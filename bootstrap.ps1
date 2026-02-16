# ndu-dark Theme Bootstrap Installer for Windows
# One-liner: irm https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.ps1 | iex

param()

$ErrorActionPreference = "Stop"

echo "🌙 ndu-dark Theme Bootstrap Installer"
echo "=========================================="
echo ""

$RepoUrl = "https://github.com/ndugram/ndu-dark.git"
$InstallDir = "$env:TEMP\ndu-dark-temp"

echo "📥 Step 1: Downloading ndu-dark..."
echo "   Repository: $RepoUrl"

# Remove old temp directory if exists
if (Test-Path $InstallDir) {
    Remove-Item -Recurse -Force $InstallDir
}

# Clone repository
try {
    git clone $RepoUrl $InstallDir --quiet
} catch {
    echo "❌ Failed to download ndu-dark"
    echo "   Make sure Git is installed: https://git-scm.com/download/win"
    exit 1
}

echo "✓ Downloaded successfully"
echo ""

echo "🚀 Step 2: Running installer..."
echo ""

# Run installer
cd $InstallDir
try {
    .\install.ps1
} catch {
    echo "❌ Installation failed"
    echo $_.Exception.Message
    exit 1
}

# Cleanup
echo ""
echo "🧹 Step 3: Cleaning up..."
$remove = Read-Host "   Remove temporary files? (y/n)"
if ($remove -eq 'y' -or $remove -eq 'Y') {
    Remove-Item -Recurse -Force $InstallDir
    echo "✓ Temporary files removed"
} else {
    echo "   Files kept at: $InstallDir"
}

echo ""
echo "🎉 Done! Enjoy your ndu-dark theme!"
