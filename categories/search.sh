#!/usr/bin/env bash
MANO_CUSTOM_NAME="🔍 Procurar"
MANO_CUSTOM_DESC="Localiza arquivos pelo nome"
MANO_CUSTOM_FUNC="mano_custom_search"
mano_custom_search(){ clear; echo "🔍 Procurar"; read -rp "Termo: " t; find /sdcard -type f -iname "*$t*" 2>/dev/null | head -n 200; read -rp "ENTER..." _; }
