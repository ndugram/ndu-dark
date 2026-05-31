# ndu-dark Theme Installer for Windows
param()
$ErrorActionPreference = "Stop"

# ─── ANSI Colors (Darcula palette) ───────────────────────────────────────────
$E      = [char]27
$RST    = "$E[0m"
$BOLD   = "$E[1m"
$ORANGE = "$E[38;5;215m"
$GREEN  = "$E[38;5;71m"
$RED    = "$E[38;5;203m"
$YELLOW = "$E[38;5;179m"
$BLUE   = "$E[38;5;111m"
$PURPLE = "$E[38;5;140m"
$GRAY   = "$E[38;5;244m"
$WHITE  = "$E[38;5;188m"

# Enable ANSI on Windows 10+
if ($PSVersionTable.PSVersion.Major -ge 5) {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    try { [Console]::TreatControlCAsInput = $false } catch {}
}

# ─── UI helpers ───────────────────────────────────────────────────────────────
function Banner {
    Write-Host ""
    Write-Host "  $ORANGE$BOLD╔════════════════════════════════════════════╗$RST"
    Write-Host "  $ORANGE$BOLD║$RST  $WHITE$BOLD  🌙   ndu-dark  —  Theme Installer       $RST$ORANGE$BOLD║$RST"
    Write-Host "  $ORANGE$BOLD║$RST  $GRAY              Windows                      $RST$ORANGE$BOLD║$RST"
    Write-Host "  $ORANGE$BOLD╚════════════════════════════════════════════╝$RST"
    Write-Host ""
}

function Done-Banner {
    Write-Host ""
    Write-Host "  $GREEN$BOLD╔════════════════════════════════════════════╗$RST"
    Write-Host "  $GREEN$BOLD║                                            ║$RST"
    Write-Host "  $GREEN$BOLD║   🎉  ndu-dark installed successfully!    ║$RST"
    Write-Host "  $GREEN$BOLD║       Reload VS Code to apply changes.    ║$RST"
    Write-Host "  $GREEN$BOLD║                                            ║$RST"
    Write-Host "  $GREEN$BOLD╚════════════════════════════════════════════╝$RST"
    Write-Host ""
}

function Notes-Banner {
    Write-Host ""
    Write-Host "  $YELLOW$BOLD╔════════════════════════════════════════════╗$RST"
    Write-Host "  $YELLOW$BOLD║  📝  First-run Notes                       ║$RST"
    Write-Host "  $YELLOW$BOLD╠════════════════════════════════════════════╣$RST"
    Write-Host "  $YELLOW$BOLD║$RST  $GRAY• IBM Plex Mono / FiraCode Nerd Font        $YELLOW$BOLD║$RST"
    Write-Host "  $YELLOW$BOLD║$RST  $GRAY  must be installed separately               $YELLOW$BOLD║$RST"
    Write-Host "  $YELLOW$BOLD║$RST  $GRAY• 'Corrupt installation' warning is normal  $YELLOW$BOLD║$RST"
    Write-Host "  $YELLOW$BOLD║$RST  $GRAY  → gear icon → Don't Show Again            $YELLOW$BOLD║$RST"
    Write-Host "  $YELLOW$BOLD╚════════════════════════════════════════════╝$RST"
    Write-Host ""
}

function Step  { param($msg); Write-Host ""; Write-Host "  $BLUE$BOLD❯  $msg$RST"; Write-Host "  $GRAY──────────────────────────────────────────$RST" }
function Ok    { param($msg); Write-Host "  $GREEN${BOLD}✓$RST  $WHITE$msg$RST" }
function Warn  { param($msg); Write-Host "  $YELLOW⚠$RST  $YELLOW$msg$RST" }
function Fail  { param($msg); Write-Host "  $RED✗$RST  $RED$msg$RST" }
function Info  { param($msg); Write-Host "  $GRAY·$RST  $GRAY$msg$RST" }
function Hint  { param($msg); Write-Host "  $PURPLE→$RST  $GRAY$msg$RST" }

# ─── JSONC strip helper ───────────────────────────────────────────────────────
function Strip-Jsonc {
    param([string]$Text)
    $Text = $Text -replace '//.*$', ''
    $Text = $Text -replace '/\*[\s\S]*?\*/', ''
    $Text = $Text -replace ',\s*([}\]])', '$1'
    return $Text
}

# ─── Init ─────────────────────────────────────────────────────────────────────
Banner
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pkgJson   = Get-Content "$scriptDir\package.json" -Raw | ConvertFrom-Json
$version   = $pkgJson.version

# ─── Step 1: VS Code CLI ──────────────────────────────────────────────────────
Step "Step 1  Checking VS Code CLI"
$codePath = Get-Command "code" -ErrorAction SilentlyContinue
if (-not $codePath) {
    $possiblePaths = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd",
        "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd",
        "${env:ProgramFiles(x86)}\Microsoft VS Code\bin\code.cmd"
    )
    $found = $false
    foreach ($p in $possiblePaths) {
        if (Test-Path $p) { $env:Path += ";$(Split-Path $p)"; $found = $true; break }
    }
    if (-not $found) {
        Fail "VS Code CLI (code) not found"
        Hint "Open VS Code → Ctrl+Shift+P → 'Shell Command: Install code command in PATH'"
        exit 1
    }
}
Ok "VS Code CLI found"

# ─── Step 2: Theme extension ──────────────────────────────────────────────────
Step "Step 2  Installing ndu-dark extension  (v$version)"
$extDir = "$env:USERPROFILE\.vscode\extensions\ndu-dark-$version"
Info "Target: $extDir"
if (Test-Path $extDir) { Remove-Item -Recurse -Force $extDir }
New-Item -ItemType Directory -Path $extDir -Force | Out-Null
Copy-Item "$scriptDir\package.json" "$extDir\" -Force
Copy-Item "$scriptDir\themes" "$extDir\themes" -Recurse -Force
if (Test-Path "$extDir\themes") {
    Ok "Extension installed"
} else {
    Fail "Failed to install extension"
    exit 1
}

# ─── Step 3: Custom UI Style ──────────────────────────────────────────────────
Step "Step 3  Installing Custom UI Style extension"
try {
    code --install-extension subframe7536.custom-ui-style --force 2>&1 | Out-Null
    Ok "Custom UI Style installed"
} catch {
    Warn "Could not install automatically"
    Hint "Install 'Custom UI Style' from Extensions marketplace manually"
}

# ─── Step 4: Fonts ────────────────────────────────────────────────────────────
Step "Step 4  Installing Bear Sans UI fonts"
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
if (-not (Test-Path $fontDir)) { New-Item -ItemType Directory -Path $fontDir -Force | Out-Null }
Info "Target: $fontDir"
try {
    $fonts = Get-ChildItem "$scriptDir\fonts\*.otf"
    $fontCount = $fonts.Count
    foreach ($font in $fonts) {
        try { Copy-Item $font.FullName $fontDir -Force -ErrorAction SilentlyContinue } catch {}
    }
    Ok "$fontCount fonts installed"
    Hint "Restart apps to load new fonts"
} catch {
    Warn "Could not install fonts automatically"
    Hint "Select all .otf files in 'fonts/' → right-click → Install"
}

# ─── Step 5: VS Code settings ─────────────────────────────────────────────────
Step "Step 5  Applying VS Code settings"
$settingsDir  = "$env:APPDATA\Code\User"
if (-not (Test-Path $settingsDir)) { New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null }
$settingsFile = Join-Path $settingsDir "settings.json"
$newSettings  = (Strip-Jsonc (Get-Content "$scriptDir\settings.json" -Raw)) | ConvertFrom-Json

if (Test-Path $settingsFile) {
    Warn "Existing settings found — creating backup"
    Copy-Item $settingsFile "$settingsFile.backup" -Force
    Info "Backup: settings.json.backup"
    try {
        $existingSettings = (Strip-Jsonc (Get-Content $settingsFile -Raw)) | ConvertFrom-Json
        $merged = @{}
        $existingSettings.PSObject.Properties | ForEach-Object { $merged[$_.Name] = $_.Value }
        $newSettings.PSObject.Properties      | ForEach-Object { $merged[$_.Name] = $_.Value }

        foreach ($key in @('workbench.iconTheme', 'workbench.productIconTheme')) {
            if ($existingSettings.PSObject.Properties[$key]) {
                $merged[$key] = $existingSettings.$key
            }
        }

        $sk = 'custom-ui-style.stylesheet'
        if ($existingSettings.$sk -and $newSettings.$sk) {
            $ms = @{}
            $existingSettings.$sk.PSObject.Properties | ForEach-Object { $ms[$_.Name] = $_.Value }
            $newSettings.$sk.PSObject.Properties      | ForEach-Object { $ms[$_.Name] = $_.Value }
            $merged[$sk] = [PSCustomObject]$ms
        }

        [PSCustomObject]$merged | ConvertTo-Json -Depth 100 | Set-Content $settingsFile
        Ok "Settings merged successfully"
    } catch {
        Warn "Could not merge automatically"
        Hint "Merge settings.json manually — backup saved"
    }
} else {
    Copy-Item "$scriptDir\settings.json" $settingsFile
    Ok "Settings applied"
}

# ─── First-run notes ──────────────────────────────────────────────────────────
$firstRunFile = Join-Path $scriptDir ".ndu_dark_first_run"
if (-not (Test-Path $firstRunFile)) {
    New-Item -ItemType File -Path $firstRunFile | Out-Null
    Notes-Banner
    Read-Host "  Press Enter to continue and reload VS Code"
}

# ─── Step 6: Reload VS Code ───────────────────────────────────────────────────
Step "Step 6  Reloading VS Code"
try {
    code --reload-window 2>$null
} catch {
    try { code $scriptDir 2>$null } catch {}
}
Ok "Reload triggered"

Done-Banner
Start-Sleep -Seconds 2
