# ndu-dark

> A dark VS Code theme with floating glass panels, refined typography, and JetBrains-inspired aesthetics.

![Version](https://img.shields.io/badge/version-1.1.0-blue?style=flat-square&color=548af7)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)
![VS Code](https://img.shields.io/badge/VS%20Code-1.60%2B-007ACC?style=flat-square&logo=visualstudiocode)

> **Work in progress** — actively refined.

---

## Preview

| Element | Style |
|---------|-------|
| Canvas | `#121216` — deep, near-black |
| Surface | `#181a1d` — floating panels |
| Accent | `#548af7` — selection, active states |
| Editor font | IBM Plex Mono |
| Terminal font | FiraCode Nerd Font Mono |
| UI font | Bear Sans UI |

---

## Features

**Panels**
- Floating sidebar, editor, terminal, and auxiliary bar — each a glass island
- Directional light borders: brighter top/left edge, subtle bottom/right
- 24px rounded corners on all major panels

**Activity bar**
- Pill-shaped container with glass inset shadow
- Accent-tinted circular indicator for active item (JetBrains-style)
- Oversized 28px icons for clarity

**Tabs**
- Accent color indicator line at top of active tab (JetBrains-style)
- Tab close buttons fade in on hover
- Bear Sans UI font

**Sidebar / File tree**
- Accent-colored left border on selected items
- Smooth gradient hover and focus states
- Rounded list rows with proper margins

**Command palette**
- Glass border, deep shadow, rounded rows
- Accent-tinted focused row

**Breadcrumbs**
- Hidden by default, fade in on hover

**Status bar**
- Dimmed text that brightens on hover with smooth transition

**Other**
- Pill-shaped scrollbar thumbs with fade
- Minimap fades to 60%, full opacity on hover
- Color-matched file icon glow via `drop-shadow`
- Warm syntax highlighting: JS/TS, Python, Go, Rust, HTML/CSS, JSON, YAML, Markdown

---

## Requirements

Before installing, have these ready:

| Dependency | Where to get |
|------------|-------------|
| VS Code 1.60+ | [code.visualstudio.com](https://code.visualstudio.com) |
| IBM Plex Mono | [fonts.google.com](https://fonts.google.com/specimen/IBM+Plex+Mono) |
| FiraCode Nerd Font | [nerdfonts.com](https://www.nerdfonts.com) |

The install script handles everything else (Custom UI Style extension, Bear Sans UI fonts, settings merge).

---

## Installation

### One-liner (recommended)

**macOS / Linux**
```bash
curl -fsSL https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.ps1 | iex
```

### Manual clone

**macOS / Linux**
```bash
git clone https://github.com/ndugram/ndu-dark.git ndu-dark
cd ndu-dark
./install.sh
```

**Windows**
```powershell
git clone https://github.com/ndugram/ndu-dark.git ndu-dark
cd ndu-dark
.\install.ps1
```

The scripts automatically:
- Install the ndu-dark color theme extension
- Install the [Custom UI Style](https://marketplace.visualstudio.com/items?itemName=subframe7536.custom-ui-style) extension
- Install Bear Sans UI fonts
- Merge `settings.json` into your VS Code config
- Reload VS Code

---

## What the CSS customizations do

| Component | What changes |
|-----------|-------------|
| Canvas | `#121216` background behind all floating panels |
| Sidebar | 24px rounded corners, glass borders, accent selection states |
| Editor | 24px rounded corners, glass borders, accent tab indicator |
| Activity bar | Pill-shaped, accent-tinted active icon indicator |
| Command center | Pill-shaped title bar widget with glass effect |
| Bottom panel | Floating with inner shadow, rounded terminal corners |
| Right sidebar | 24px rounded corners, glass borders |
| Notifications | 14px rounded, glass borders, deep shadow |
| Command palette | 14px rounded, accent-tinted focused rows |
| Tabs | Accent top-line on active tab, fade-in close button |
| Scrollbars | Pill-shaped thumbs, opacity transition |
| Breadcrumbs | Hidden until hover, smooth fade |
| Status bar | Dimmed until hover |
| File icons | Color-matched glow via `drop-shadow` |

---

## Troubleshooting

### Changes aren't taking effect

Cycle the extension:
1. **Command Palette** → `Custom UI Style: Disable` → Reload
2. **Command Palette** → `Custom UI Style: Enable` → Reload

### "Corrupt installation" warning

Expected after enabling Custom UI Style — VS Code detects the modified `workbench.html`. Dismiss it or select **Don't Show Again**.

### Styles conflict with a previous CSS extension

If you previously used **Custom CSS and JS Loader** (`be5invis.vscode-custom-css`), it may have left stale CSS injected directly into `workbench.html`. Reinstall VS Code to get a clean slate, then use only Custom UI Style.

### Font not showing

IBM Plex Mono and FiraCode Nerd Font must be installed at the OS level — the install script will remind you if they're missing.

---

## Credits

Inspired by JetBrains IDE new UI (PyCharm, IntelliJ).

---

## License

MIT
