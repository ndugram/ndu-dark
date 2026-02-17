# ndu-dark

**A dark VS Code theme with deep backgrounds and warm syntax highlighting**

---

## **THIS THEME IS STILL A WORK IN PROGRESS**

A dark color theme for Visual Studio Code with floating glass-like panels, rounded corners, smooth animations, and a deeply refined UI.

## Features

- Deep dark canvas (`#131217`) with floating panels
- Glass-effect borders with directional light simulation (brighter top/left, subtle bottom/right)
- Rounded corners on all panels, notifications, command palette, and sidebars
- Pill-shaped activity bar with glass selection indicators
- Breadcrumb bar and status bar that dim when not hovered
- Tab close buttons that fade in on hover
- Smooth transitions on sidebar selections, scrollbars, and status bar
- Pill-shaped scrollbar thumbs
- Warm syntax highlighting with comprehensive language support (JS/TS, Python, Go, Rust, HTML/CSS, JSON, YAML, Markdown)
- IBM Plex Mono in the editor, FiraCode Nerd Font Mono in the terminal

## Installation

This theme has two parts: a **color theme** and **CSS customizations** that create the floating glass panel look.

### One-Liner Install (Recommended)

The fastest way to install:

#### macOS/Linux

```bash
curl -fsSL https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.sh | bash
```

#### Windows

```powershell
irm https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.ps1 | iex
```

### Manual Clone Install

If you prefer to clone first:

#### macOS/Linux

```bash
git clone https://github.com/ndugram/ndu-dark.git ndu-dark
cd ndu-dark
./install.sh
```

#### Windows

```powershell
git clone https://github.com/ndugram/ndu-dark.git ndu-dark
cd ndu-dark
.\install.ps1
```

The scripts will automatically:
- ✅ Install the ndu-dark theme extension
- ✅ Install the Custom UI Style extension
- ✅ Install Bear Sans UI fonts
- ✅ Merge settings into your VS Code: configuration
- ✅ Enable Custom UI Style and reload VS Code:

> **Note:** IBM Plex Mono and FiraCode Nerd Font Mono must be installed separately (the script will remind you).

On Windows (PowerShell):
```powershell
git clone https://github.com/ndugram/ndu-dark.git ndu-dark
cd ndu-dark
$ext = "$env:USERPROFILE\.vscode\extensions\ndu-dark-1.1.0"
New-Item -ItemType Directory -Path $ext -Force
Copy-Item package.json $ext\
Copy-Item themes $ext\themes -Recurse
```

## What the CSS customizations do

| Element | Effect |
|---------|--------|
| **Canvas** | Deep dark background (`#131217`) behind all panels |
| **Sidebar** | Floating with 18px rounded corners, glass borders, drop shadow |
| **Editor** | Floating with 18px rounded corners, glass borders, browser-tab effect |
| **Activity bar** | Pill-shaped with glass inset shadows, circular selection indicator |
| **Command center** | Pill-shaped with glass effect |
| **Bottom panel** | Floating with 12px rounded corners, glass borders |
| **Right sidebar** | Floating with 18px rounded corners, glass borders |
| **Notifications** | 12px rounded corners, glass borders, deep drop shadow |
| **Command palette** | 14px rounded corners, glass borders, rounded list rows |
| **Scrollbars** | Pill-shaped thumbs with fade transition |
| **Tabs** | Browser-tab style (active tab open at bottom), close button fades in on hover |
| **Breadcrumbs** | Hidden until hover with smooth fade transition |
| **Status bar** | Dimmed text that brightens on hover |
| **File icons** | Color-matched glow via drop-shadow (best with Seti Folder icon theme) |

## Troubleshooting

### Changes aren't taking effect
Try disabling and re-enabling Custom UI Style:
1. **Command Palette** > **Custom UI Style: Disable**
2. Reload VS Code
3. **Command Palette** > **Custom UI Style: Enable**
4. Reload VS Code

### "Corrupt installation" warning
This is expected after enabling Custom UI Style. Dismiss it or select **Don't Show Again**.

### Previously used "Custom CSS and JS Loader" extension
If you previously used the **Custom CSS and JS Loader** extension (`be5invis.vscode-custom-css`), it may have injected CSS directly into VS Code's `workbench.html` that persists even after disabling. If styles conflict, reinstall VS Code to get a clean `workbench.html`, then use only **Custom UI Style**.

## Credits

Inspired by modern JetBrains IDE themes.

## License

MIT
