<div align="center">

# ndu-dark

**A VS Code theme that looks like PyCharm stayed up all night.**

Deep dark canvas. Floating glass panels. Accent-lit selections. Warm syntax.

<br/>

[![Version](https://img.shields.io/badge/version-1.1.0-548af7?style=for-the-badge&labelColor=1a1b1e)](https://github.com/ndugram/ndu-dark/releases)
[![License](https://img.shields.io/badge/license-MIT-3fb950?style=for-the-badge&labelColor=1a1b1e)](LICENSE)
[![VS Code](https://img.shields.io/badge/VS%20Code-1.60+-007ACC?style=for-the-badge&labelColor=1a1b1e&logo=visualstudiocode&logoColor=007ACC)](https://code.visualstudio.com)

<br/>

<!-- Replace with actual screenshot -->
<!-- ![ndu-dark preview](preview/preview.png) -->

</div>

---

## What it looks like

Every panel floats. Every border catches light from the top-left. Every selected item glows with `#548af7`. Nothing is flat. Nothing is noisy.

```
Canvas   #121216  ████  near-black void behind all panels
Surface  #181a1d  ████  panel background, slightly lifted
Accent   #548af7  ████  selections, active tabs, focus rings
```

| Font | Used for |
|------|----------|
| IBM Plex Mono | Editor |
| FiraCode Nerd Font Mono | Terminal |
| Bear Sans UI | UI chrome, tabs, sidebar |

---

## Features

<details>
<summary><strong>Floating panels</strong></summary>

- Sidebar, editor, terminal, right sidebar — each is an independent glass island
- Directional light simulation: `rgba(255,255,255,0.1)` top border, `rgba(255,255,255,0.02)` bottom
- `24px` rounded corners on all major panels
- `6px` gap between panels, showing the canvas beneath

</details>

<details>
<summary><strong>Activity bar</strong></summary>

- Pill-shaped container with glass inset shadow
- Active icon: accent-tinted circular indicator — no default VS Code line indicator
- `28px` icons for clarity at any DPI
- Badge counters scaled to `0.8` and pinned top-right

</details>

<details>
<summary><strong>Tabs</strong></summary>

- Active tab: `#548af7` indicator line at top — JetBrains-style
- Close button invisible until hover, fades in smoothly
- Bear Sans UI font across all tabs
- No tab borders — tabs separated by subtle box-shadows only

</details>

<details>
<summary><strong>Sidebar / File tree</strong></summary>

- Selected item: blue left-border accent + subtle gradient background
- Focused + selected: stronger accent, full `#548af7` left bar
- Hover: soft gradient, no jarring color flash
- All rows: `6px` rounded, `4px` horizontal margins

</details>

<details>
<summary><strong>Everything else</strong></summary>

- **Command palette** — glass borders, deep shadow, accent-tinted focused row
- **Breadcrumbs** — hidden until hover, 400ms fade
- **Status bar** — dimmed text, brightens on hover
- **Minimap** — 60% opacity, full on hover
- **Scrollbars** — pill-shaped thumbs with opacity transition
- **File icons** — color-matched glow via `drop-shadow`
- **Notifications / dialogs** — `14px` rounded, glass borders
- **Syntax** — warm highlights for JS/TS, Python, Go, Rust, HTML/CSS, JSON, YAML, Markdown

</details>

---

## Install

### One-liner

> Installs the theme, Custom UI Style extension, Bear Sans UI fonts, and merges settings automatically.

**macOS / Linux**
```bash
curl -fsSL https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/ndugram/ndu-dark/main/bootstrap.ps1 | iex
```

### Manual

```bash
git clone https://github.com/ndugram/ndu-dark.git
cd ndu-dark
./install.sh          # macOS / Linux
# .\install.ps1       # Windows
```

The script does:
1. Copies extension to `~/.vscode/extensions/ndu-dark-1.1.0/`
2. Installs [Custom UI Style](https://marketplace.visualstudio.com/items?itemName=subframe7536.custom-ui-style) via `code --install-extension`
3. Installs Bear Sans UI fonts system-wide
4. Deep-merges `settings.json` into your VS Code config (non-destructive)
5. Reloads VS Code

### Prerequisites

Install these manually before running the script:

| Font | Link |
|------|------|
| IBM Plex Mono | [fonts.google.com/specimen/IBM+Plex+Mono](https://fonts.google.com/specimen/IBM+Plex+Mono) |
| FiraCode Nerd Font | [nerdfonts.com](https://www.nerdfonts.com/font-downloads) |

---

## CSS customizations reference

The floating panel look requires [Custom UI Style](https://marketplace.visualstudio.com/items?itemName=subframe7536.custom-ui-style). The `settings.json` in this repo provides all rules.

| Selector | Effect |
|----------|--------|
| `.monaco-workbench` | CSS variable definitions — edit here to retheme everything |
| `.part.sidebar` | Floating glass panel, rounded corners, accent selection |
| `.part.editor` | Floating glass panel, accent tab top indicator |
| `.part.activitybar` | Pill container, accent active icon |
| `.part.panel.bottom` | Floating terminal/output panel |
| `.part.auxiliarybar` | Right sidebar, same glass style |
| `.quick-input-widget` | Command palette — glass, deep shadow |
| `.tabs-container` | Tab bar bottom border via background-image trick |
| `.tab.active` | `#548af7` top indicator via box-shadow |
| `.monaco-breadcrumbs` | Hidden until hover |
| `.scrollbar .slider` | Pill shape, opacity transition |

### CSS variables

All values in one place — `".monaco-workbench"` block in `settings.json`:

```json
"--islands-panel-radius": "24px"
"--islands-widget-radius": "14px"
"--islands-input-radius": "12px"
"--islands-item-radius": "6px"
"--islands-panel-gap": "6px"
"--islands-bg-canvas": "#121216"
"--islands-bg-surface": "#181a1d"
"--islands-tab-border": "#25262a"
"--islands-accent": "#548af7"
```

---

## Troubleshooting

<details>
<summary><strong>Changes aren't taking effect</strong></summary>

Cycle the extension:
1. `Ctrl+Shift+P` → `Custom UI Style: Disable` → Reload VS Code
2. `Ctrl+Shift+P` → `Custom UI Style: Enable` → Reload VS Code

</details>

<details>
<summary><strong>"Your VS Code installation appears to be corrupt"</strong></summary>

Expected. Custom UI Style patches `workbench.html` — VS Code detects the checksum mismatch and warns you. Click **Don't Show Again**. This is cosmetic only; nothing is actually broken.

</details>

<details>
<summary><strong>Conflict with Custom CSS and JS Loader</strong></summary>

If you previously used `be5invis.vscode-custom-css`, it may have injected CSS directly into `workbench.html` that persists after disabling. Reinstall VS Code to get a clean `workbench.html`, then use only Custom UI Style.

</details>

<details>
<summary><strong>Font not rendering</strong></summary>

IBM Plex Mono and FiraCode Nerd Font must be installed at OS level — not just as VS Code settings. The install script checks for them and prints a reminder if missing.

</details>

---

## Contributing

1. Fork → branch → change
2. Test in VS Code with Custom UI Style enabled
3. PR with a before/after screenshot if it's a visual change

Easiest place to start: adjust CSS variables in `settings.json` to experiment with spacing, colors, radii.

---

<div align="center">

Inspired by [JetBrains New UI](https://www.jetbrains.com/help/idea/new-ui.html) — PyCharm, IntelliJ.

MIT © [ndugram](https://github.com/ndugram)

</div>
