#!/usr/bin/env bash
# MANO v3.1.5 - loader único oficial (sem core/ bugado)
export MANO_HOME="$HOME/.mano"
export MANO_CATEGORY_DIR="$MANO_HOME/categories"
export MANO_ALIAS_DIR="$MANO_HOME/aliases"
mkdir -p "$MANO_CATEGORY_DIR" "$MANO_ALIAS_DIR"
if [[ -d "$MANO_ALIAS_DIR" ]]; then shopt -s nullglob; for _f in "$MANO_ALIAS_DIR"/*.sh; do source "$_f" 2>/dev/null; done; shopt -u nullglob; fi
mano_load_custom_categories(){
  MANO_CUSTOM_NAMES=(); MANO_CUSTOM_DESCS=(); MANO_CUSTOM_FUNCS=(); MANO_CUSTOM_FILES=()
  shopt -s nullglob; for file in "$MANO_CATEGORY_DIR"/*.sh; do unset MANO_CUSTOM_NAME MANO_CUSTOM_DESC MANO_CUSTOM_FUNC; source "$file" 2>/dev/null; if [[ -n "${MANO_CUSTOM_NAME:-}" && -n "${MANO_CUSTOM_FUNC:-}" ]]; then MANO_CUSTOM_NAMES+=("$MANO_CUSTOM_NAME"); MANO_CUSTOM_DESCS+=("${MANO_CUSTOM_DESC:-}"); MANO_CUSTOM_FUNCS+=("$MANO_CUSTOM_FUNC"); MANO_CUSTOM_FILES+=("$file"); fi; done; shopt -u nullglob
}
mano_load_custom_categories
alias mano-reload='source "$MANO_HOME/loader.sh" && echo "✅ MANO v3.1.5: ${#MANO_CUSTOM_NAMES[@]} cats"'
mano-list(){ echo; echo "📂 Categorias (${#MANO_CUSTOM_NAMES[@]}):"; local i; for i in "${!MANO_CUSTOM_NAMES[@]}"; do printf " %2d) %s (%s)
" $((i+1)) "${MANO_CUSTOM_NAMES[i]}" "${MANO_CUSTOM_FUNCS[i]}"; done; }
mano(){
  local fixed_names=("Ferramentas" "Rede" "Pacotes" "Arquivos" "Navegacao" "Sistema" "Dev" "IA" "PowerShell")
  local fixed_funcs=("mano_custom_ferramentas" "mano_custom_rede" "mano_custom_pacotes" "mano_custom_arquivos" "mano_custom_navegacao" "mano_custom_sistema" "mano_custom_dev" "mano_custom_ia" "mano_custom_powershell")
  while true; do clear; echo "=== MANO V3 TERMUX ==="; echo "Local: $PWD"; echo ""; local i; for i in "${!fixed_names[@]}"; do printf " %2d) %-12s" $((i+1)) "${fixed_names[i]}"; (( (i+1) % 3 == 0 )) && echo ""; done; echo ""; mano_load_custom_categories; for i in "${!MANO_CUSTOM_NAMES[@]}"; do local skip=0; for f in "${fixed_funcs[@]}"; do [[ "${MANO_CUSTOM_FUNCS[i]}" == "$f" ]] && skip=1; done; (( skip == 0 )) && printf " %2d) %s
" $((i+10)) "${MANO_CUSTOM_NAMES[i]}"; done; echo ""; echo " r) Recarregar 0) Sair"; read -rp " >> " opt; case "$opt" in 0) break;; r|R) source "$MANO_HOME/loader.sh";; [1-9]) idx=$((opt-1)); func="${fixed_funcs[idx]}"; if declare -f "$func" >/dev/null 2>&1; then "$func"; else echo ""; echo " [${fixed_names[idx]}] - em construção"; read -rp " ENTER..." _; fi;; 1[0-9]|2[0-9]) idx=$((opt-10)); local extras=(); local efuncs=(); for j in "${!MANO_CUSTOM_FUNCS[@]}"; do local is_fixed=0; for f in "${fixed_funcs[@]}"; do [[ "${MANO_CUSTOM_FUNCS[j]}" == "$f" ]] && is_fixed=1; done; (( is_fixed == 0 )) && extras+=("${MANO_CUSTOM_NAMES[j]}") && efuncs+=("${MANO_CUSTOM_FUNCS[j]}"); done; if (( idx < ${#efuncs[@]} )); then "${efuncs[idx]}"; else echo "Inválida"; sleep 1; fi;; *) echo "Inválida"; sleep 1;; esac; done
}
