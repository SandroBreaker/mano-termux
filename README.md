# MANO - Termux Toolkit

Menu rápido pra facilitar a vida no Termux.

## Estrutura
```
~/.mano/
  loader.sh          # carrega tudo + menu principal `mano`
  mano-add           # gerenciador de alias/categoria
  toolkit.sh         # exporta pasta pra TXT sem recursão
  categories/        # uma categoria = um arquivo .sh com FUNC
  aliases/           # um alias = um arquivo .sh
```

## Instalação
```bash
git clone https://github.com/SEUUSER/mano.git ~/.mano
chmod +x ~/.mano/loader.sh ~/.mano/mano-add ~/.mano/categories/*.sh ~/.mano/aliases/*.sh
echo 'source ~/.mano/loader.sh' >> ~/.bashrc
source ~/.mano/loader.sh
mano
```

## Comandos
- `mano` - abre menu
- `mano-list` - lista categorias
- `mano-reload` - recarrega
- `toolkit` - exporta pasta atual
- `search` / `cls` / `gaming` / etc

## Categorias atuais
- 🧰 Ferramentas (limpar cache, info sistema, bateria, etc)
- 🔍 Procurar
- 🎮 Gaming
- 🛠️ Toolkit

## Criar nova categoria
```bash
mano-add
# ou manual:
cat > ~/.mano/categories/minha.sh <<'EOC'
MANO_CUSTOM_NAME="Minha"
MANO_CUSTOM_DESC="Descrição"
MANO_CUSTOM_FUNC="mano_custom_minha"
mano_custom_minha(){ echo "ola"; read -rp "ENTER..." _; }
EOC
```

## v3.1.5
- Fix menu principal (opção 1 não fechava mais)
- Fix duplicata de case Toolkit/toolkit
- Ferramentas real implementada
- Loader com dispatch fixas -> custom
