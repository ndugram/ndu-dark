#!/bin/bash
set -e

# ─── Colors (Darcula palette) ─────────────────────────────────────────────────
RST='\033[0m'; BOLD='\033[1m'; DIM='\033[2m'
ORANGE='\033[38;5;215m'; DORANGE='\033[38;5;172m'
GREEN='\033[38;5;71m';   RED='\033[38;5;203m'
YELLOW='\033[38;5;179m'; BLUE='\033[38;5;111m'
PURPLE='\033[38;5;140m'; GRAY='\033[38;5;244m'
WHITE='\033[38;5;188m'

# ─── UI helpers ───────────────────────────────────────────────────────────────
banner() {
    local W=44
    local title="  🌙   ndu-dark  —  Theme Installer   "
    local sub="          macOS  /  Linux              "
    echo -e ""
    echo -e "${ORANGE}${BOLD}  ╔$(printf '═%.0s' $(seq 1 $W))╗${RST}"
    echo -e "${ORANGE}${BOLD}  ║${RST}${WHITE}${BOLD}${title}${RST}${ORANGE}${BOLD}  ║${RST}"
    echo -e "${ORANGE}${BOLD}  ║${RST}${GRAY}${sub}${RST}${ORANGE}${BOLD}  ║${RST}"
    echo -e "${ORANGE}${BOLD}  ╚$(printf '═%.0s' $(seq 1 $W))╝${RST}"
    echo -e ""
}

done_banner() {
    echo -e ""
    echo -e "${GREEN}${BOLD}  ╔════════════════════════════════════════════╗${RST}"
    echo -e "${GREEN}${BOLD}  ║                                            ║${RST}"
    echo -e "${GREEN}${BOLD}  ║   🎉  ndu-dark installed successfully!    ║${RST}"
    echo -e "${GREEN}${BOLD}  ║       Reload VS Code to apply changes.    ║${RST}"
    echo -e "${GREEN}${BOLD}  ║                                            ║${RST}"
    echo -e "${GREEN}${BOLD}  ╚════════════════════════════════════════════╝${RST}"
    echo -e ""
}

notes_banner() {
    echo -e ""
    echo -e "${YELLOW}${BOLD}  ╔════════════════════════════════════════════╗${RST}"
    echo -e "${YELLOW}${BOLD}  ║  📝  First-run Notes                       ║${RST}"
    echo -e "${YELLOW}${BOLD}  ╠════════════════════════════════════════════╣${RST}"
    echo -e "${YELLOW}${BOLD}  ║${RST}  ${GRAY}• IBM Plex Mono / FiraCode Nerd Font        ${YELLOW}${BOLD}║${RST}"
    echo -e "${YELLOW}${BOLD}  ║${RST}  ${GRAY}  must be installed separately               ${YELLOW}${BOLD}║${RST}"
    echo -e "${YELLOW}${BOLD}  ║${RST}  ${GRAY}• 'Corrupt installation' warning is normal  ${YELLOW}${BOLD}║${RST}"
    echo -e "${YELLOW}${BOLD}  ║${RST}  ${GRAY}  → gear icon → Don't Show Again            ${YELLOW}${BOLD}║${RST}"
    echo -e "${YELLOW}${BOLD}  ╚════════════════════════════════════════════╝${RST}"
    echo -e ""
}

step() {
    echo -e ""
    echo -e "${BLUE}${BOLD}  ❯  $*${RST}"
    echo -e "${GRAY}  ──────────────────────────────────────────${RST}"
}

ok()   { echo -e "  ${GREEN}${BOLD}✓${RST}  ${WHITE}$*${RST}"; }
warn() { echo -e "  ${YELLOW}⚠${RST}  ${YELLOW}$*${RST}"; }
fail() { echo -e "  ${RED}✗${RST}  ${RED}$*${RST}"; }
info() { echo -e "  ${GRAY}·${RST}  ${GRAY}$*${RST}"; }
hint() { echo -e "  ${PURPLE}→${RST}  ${GRAY}$*${RST}"; }

# ─── Init ─────────────────────────────────────────────────────────────────────
banner
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=$(node -e "console.log(require('$SCRIPT_DIR/package.json').version)" 2>/dev/null || echo "1.2.0")

# ─── Step 1: VS Code CLI ──────────────────────────────────────────────────────
step "Step 1  Checking VS Code CLI"
if ! command -v code &> /dev/null; then
    fail "VS Code CLI (code) not found"
    hint "Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
    exit 1
fi
ok "Found at $(command -v code)"

# ─── Step 2: Theme extension ──────────────────────────────────────────────────
step "Step 2  Installing ndu-dark extension  (v${VERSION})"
EXT_DIR="$HOME/.vscode/extensions/ndu-dark-${VERSION}"
info "Target: $EXT_DIR"
rm -rf "$EXT_DIR"
mkdir -p "$EXT_DIR"
cp "$SCRIPT_DIR/package.json" "$EXT_DIR/"
cp -r "$SCRIPT_DIR/themes" "$EXT_DIR/"
if [ -d "$EXT_DIR/themes" ]; then
    ok "Extension installed"
else
    fail "Failed to install extension"
    exit 1
fi

# ─── Step 3: Custom UI Style ──────────────────────────────────────────────────
step "Step 3  Installing Custom UI Style extension"
if code --install-extension subframe7536.custom-ui-style --force 2>/dev/null; then
    ok "Custom UI Style installed"
else
    warn "Could not install automatically"
    hint "Install 'Custom UI Style' from Extensions marketplace manually"
fi

# ─── Step 4: Fonts ────────────────────────────────────────────────────────────
step "Step 4  Installing Bear Sans UI fonts"
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
else
    warn "Unknown OS — install fonts from 'fonts/' manually"
    FONT_DIR=""
fi

if [ -n "$FONT_DIR" ]; then
    info "Target: $FONT_DIR"
    FONT_COUNT=$(find "$SCRIPT_DIR/fonts" -name "*.otf" 2>/dev/null | wc -l | tr -d ' ')
    cp "$SCRIPT_DIR/fonts/"*.otf "$FONT_DIR/" 2>/dev/null || true
    [[ "$OSTYPE" == "linux-gnu"* ]] && fc-cache -f 2>/dev/null || true
    ok "${FONT_COUNT} fonts installed"
    hint "Restart apps to load new fonts"
fi

# ─── Step 5: VS Code settings ─────────────────────────────────────────────────
step "Step 5  Applying VS Code settings"
SETTINGS_DIR="$HOME/.config/Code/User"
[[ "$OSTYPE" == "darwin"* ]] && SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$SETTINGS_DIR"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    warn "Existing settings found — creating backup"
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
    info "Backup: settings.json.backup"
    if command -v node &> /dev/null; then
        node << 'NODE_SCRIPT'
const fs = require('fs'), path = require('path');

function stripJsonc(text) {
    text = text.replace(/\/\/(?=(?:[^"\\]|\\.)*$)/gm, '');
    text = text.replace(/\/\*[\s\S]*?\*\//g, '');
    text = text.replace(/,\s*([}\]])/g, '$1');
    return text;
}

const scriptDir = process.cwd();
const newSettings = JSON.parse(stripJsonc(fs.readFileSync(path.join(scriptDir, 'settings.json'), 'utf8')));
const settingsDir = process.platform === 'darwin'
    ? path.join(process.env.HOME, 'Library/Application Support/Code/User')
    : path.join(process.env.HOME, '.config/Code/User');

const settingsFile = path.join(settingsDir, 'settings.json');
const existingSettings = JSON.parse(stripJsonc(fs.readFileSync(settingsFile, 'utf8')));
const merged = { ...existingSettings, ...newSettings };

for (const key of ['workbench.iconTheme', 'workbench.productIconTheme']) {
    if (existingSettings[key] !== undefined) merged[key] = existingSettings[key];
}

const sk = 'custom-ui-style.stylesheet';
if (existingSettings[sk] && newSettings[sk]) {
    merged[sk] = { ...existingSettings[sk], ...newSettings[sk] };
}

const ek = 'custom-ui-style.electron';
if (existingSettings[ek] && newSettings[ek]) {
    merged[ek] = { ...existingSettings[ek], ...newSettings[ek] };
}

const ck = 'workbench.colorCustomizations';
if (existingSettings[ck] && newSettings[ck]) {
    merged[ck] = { ...existingSettings[ck], ...newSettings[ck] };
    if (existingSettings[ck]['[ndu-dark]'] && newSettings[ck]['[ndu-dark]']) {
        merged[ck]['[ndu-dark]'] = { ...existingSettings[ck]['[ndu-dark]'], ...newSettings[ck]['[ndu-dark]'] };
    }
}

fs.writeFileSync(settingsFile, JSON.stringify(merged, null, 2));
NODE_SCRIPT
        ok "Settings merged successfully"
    else
        warn "Node.js not found — merge settings.json manually"
        hint "Backup saved to settings.json.backup"
    fi
else
    cp "$SCRIPT_DIR/settings.json" "$SETTINGS_FILE"
    ok "Settings applied"
fi

# ─── First-run notes ──────────────────────────────────────────────────────────
FIRST_RUN_FILE="$SCRIPT_DIR/.ndu_dark_first_run"
if [ ! -f "$FIRST_RUN_FILE" ]; then
    touch "$FIRST_RUN_FILE"
    notes_banner
    if [ -t 0 ]; then
        echo -ne "  ${GRAY}Press Enter to continue and reload VS Code...${RST} "
        read
    fi
fi

# ─── Step 6: Reload VS Code ───────────────────────────────────────────────────
step "Step 6  Reloading VS Code"
[[ "$OSTYPE" == "darwin"* ]] && \
    osascript -e 'display notification "ndu-dark installed!" with title "🌙 ndu-dark"' 2>/dev/null || true
code --reload-window 2>/dev/null || code . 2>/dev/null || true
ok "Reload triggered"

done_banner
