#!/usr/bin/env bash
MANO_CUSTOM_NAME="🛠️ Toolkit"
MANO_CUSTOM_DESC="Exporta pasta pra TXT sem recursão"
MANO_CUSTOM_FUNC="mano_custom_toolkit"
mano_custom_toolkit(){ local ROOT="${1:-$PWD}"; local OUT="${2:-mano-dump.txt}"; local BN="$(basename "$OUT")"; local TMP=$(mktemp); { find "$ROOT" -type f ! -name "*.txt" ! -name "*.zip" ! -name "$BN" ! -path "*/.git/*" | sort; } > "$TMP"; mv "$TMP" "$ROOT/$BN"; echo "✅ $ROOT/$BN"; }
