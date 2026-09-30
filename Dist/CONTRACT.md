# Dist Contract — Portable Fabula Source Toolkit

Canonical copy-ready tree: `/Users/rosario/work/FabulaItemsProvider/Dist/`

## Layout

| Path | Purpose |
|------|---------|
| `Dist/Foundation/` | Dependency-free utilities |
| `Dist/Theme/` | Injectable semantic tokens (no Bundle.module) |
| `Dist/Components/<Name>/` | Production-shaped public APIs (Fabula* prefix) |
| `Dist/Examples/<Name>/` | Synthetic demos (not for Release shipping) |
| `Dist/Provenance/` | MIT license, upstream hashes, catalog |
| `Dist/Inventory/` | Authoritative audit (components.json) |
| `Manifests/` | Full, dependency-free, per-consumer manifests |

## Naming
- Public types: Fabula prefix. Helpers private/fileprivate.
- Do not expose P-number names in production APIs.

## Package boundaries
- No import FabulaItemsProvider, ItemsProvider, FAnyView, ItemData, Bundle.module.
- No undeclared third-party imports. Theme injectable via FabulaTheme.

## Provenance
MIT notice + upstream path/SHA-256 in catalog.json + adaptation notes.

## Consumer integration
Manifest select -> sync --apply -> XcodeGen generate.sh. sync --check detects drift.

## PASS PLUS
Vendored root: PassPlus/Utilities/FabulaToolkit/. No Fabula SPM package.
