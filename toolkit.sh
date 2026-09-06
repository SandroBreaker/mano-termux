#!/usr/bin/env bash
# MANO Toolkit v3 - gera dump sem recursão
# FIX: ignora *.txt para não incluir a si mesmo

ROOT="${1:-.}"
OUTPUT="${2:-atalhos_do_sistema-v3.txt}"

# ignora .txt, .git, __pycache__, etc
echo "## $ROOT - $(date) " > "$OUTPUT"
echo "## Gerado por mano toolkit v3 (ignora *.txt)" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# lista arquivos, ignorando *.txt
echo "### LISTAGEM DE ARQUIVOS (sem *.txt)" >> "$OUTPUT"
find "$ROOT" -type f \
    ! -name "*.txt" \
    ! -path "*/.git/*" \
    ! -path "*/__pycache__/*" \
    ! -name "$OUTPUT" \
    | sort >> "$OUTPUT"

echo "" >> "$OUTPUT"
echo "--- CONTEUDO ---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

while IFS= read -r file; do
    # só inclui .sh e arquivos relevantes do mano
    if [[ "$file" == *.sh ]] || [[ "$file" == *mano-add* ]] || [[ "$file" == *.md ]]; then
        echo "#### File: $file" >> "$OUTPUT"
        cat "$file" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
    fi
done < <(find "$ROOT" -type f ! -name "*.txt" ! -path "*/.git/*" | sort)

echo "✅ Dump gerado em $OUTPUT sem recursão"
