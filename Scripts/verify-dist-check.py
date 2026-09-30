#!/usr/bin/env python3
import json, re, sys
from pathlib import Path
root = Path(__file__).resolve().parents[1]
inv = json.loads((root / "Dist/Inventory/components.json").read_text())
assert inv["summary"]["total_files"] == 287, inv["summary"]["total_files"]
assert not inv["summary"]["duplicate_ids"]
rej = json.loads((root / "Dist/Inventory/rejected-dispositions.json").read_text())
assert "rejected" in rej and "pattern_only" in rej
bad = []
for f in (root / "Dist").rglob("*.swift"):
    for i, line in enumerate(f.read_text().splitlines(), 1):
        code = line.split("//", 1)[0]
        if re.search(r"import\\s+FabulaItemsProvider\\b", code):
            bad.append((str(f), i, "import FabulaItemsProvider"))
        if "Bundle.module" in code:
            bad.append((str(f), i, "Bundle.module"))
        for tp in ("Alamofire", "AxisSheet", "LottieUI", "UnsplashProvider", "Scroller", "AnimateText", "SDWebImageSwiftUI"):
            if re.search(rf"import\\s+{tp}\\b", code):
                bad.append((str(f), i, tp))
if bad:
    print("[FAIL]", bad[:30])
    sys.exit(1)
lic = (root / "Dist/Provenance/LICENSE").read_text()
assert "MIT License" in lic
cat = json.loads((root / "Dist/Provenance/catalog.json").read_text())
assert cat["license_present"] and cat["entry_count"] > 0
print(f"[PASS] verify-dist inventory=287 provenance={cat["entry_count"]} rejected={rej["counts"]["rejected"]}")
