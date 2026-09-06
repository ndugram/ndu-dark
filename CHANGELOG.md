# Changelog

## 1.2.0 — 2026-09-06

- **Liquid Glass** — panels, command palette, menus, notifications, hovers, suggest
  widget and dialogs are now real frosted glass
- Added `custom-ui-style.electron` window vibrancy (`under-window`) — macOS blurs the
  desktop behind the whole window
- Added scoped `workbench.colorCustomizations["[ndu-dark]"]` with alpha backgrounds so
  the vibrancy shows through
- New CSS variables: `--islands-glass-chrome`, `--islands-glass-surface`,
  `--islands-glass-strip`, `--islands-blur`, `--islands-blur-strong`, `--islands-glass-edge`
- `backdrop-filter: blur() saturate()` on every workbench part and overlay
- Installers now deep-merge `custom-ui-style.electron` and `workbench.colorCustomizations`
- Docs: Liquid Glass section + troubleshooting for blur / transparency / readability

## 1.1.0 — 2026-02-14

- Renamed to ndu-dark
- Improved sidebar spacing and layout
- Updated all rounded corners to be more uniform (PyCharm-inspired)
- Fixed repository links and installation scripts
- Enhanced overall visual consistency

## 1.0.0 — 2026-02-13

- Initial release
- Full UI color theming (editor, sidebar, tabs, panels, terminal, and more)
- Syntax highlighting for JS/TS, Python, Go, Rust, HTML/CSS, JSON, YAML, Markdown
