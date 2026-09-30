#!/bin/bash
set -euo pipefail
ROOT="\$(cd "\$(dirname "\$0")/.." && pwd)"
cd "\$ROOT"
python3 Scripts/audit-fabula-inventory.py
python3 Scripts/build-dist-examples.py
test -f Dist/Foundation/FabulaFoundation.swift
test -f Dist/Theme/FabulaTheme.swift
test -f Dist/CONTRACT.md
test -f Dist/Provenance/LICENSE
test -f Dist/Provenance/catalog.json
test -f Dist/Inventory/rejected-dispositions.json
echo "[PASS] build-dist"
