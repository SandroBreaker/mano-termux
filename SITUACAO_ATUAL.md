# MANO-Termux - Situação Atual v3.1.5

> Data: 06/09/2026 - Unificação concluída

## 🔗 Links e Caminhos

| Item | Caminho / Link |
|------|---------------|
| **GitHub (oficial)** | `https://github.com/SandroBreaker/mano-termux.git` |
| **Repo local DEV** | `~/mano` = `/data/data/com.termux/files/home/mano` |
| **Instalação (runtime)** | `~/.mano` = `/data/data/com.termux/files/home/.mano` |
| **Download (limpo)** | `/sdcard/Download` - sem arquivos soltos de MANO |
| **Arquivo morto** | `/sdcard/Download/mano-legacy-archive/` - pode apagar depois |

> **REGRA DE OURO:** Edita sempre em `~/mano`, testa copiando pra `~/.mano`, commita e push pro GitHub.

---

## ✅ O que funciona HOJE (v3.1.5)

### Estrutura unificada (14 arquivos, 4 pastas)
```
~/mano/
├── README.md
├── loader.sh          # v3.1.5 - ÚNICO loader, sem core/ bugado
├── mano-add           # cria alias novo
├── toolkit.sh         # wrapper pro dump
├── aliases/
│   ├── cls.sh         # alias cls='clear'
│   ├── gaming.sh      # alias gaming='mano_custom_gaming'
│   ├── search.sh      # alias search='mano_custom_search'
│   └── toolkit.sh     # alias toolkit='mano_custom_toolkit'
├── categories/
│   ├── ferramentas.sh # 🧰 REAL - funciona (opção 1)
│   ├── gaming.sh      # 🎮 Gaming
│   ├── search.sh      # 🔍 Procurar
│   └── toolkit.sh     # 🛠️ Toolkit - dump sem recursão
└── tools/
    ├── gemini.py
    └── gemini-agent.py
```

### Menu `mano`
```
=== MANO V3 TERMUX ===
 1) Ferramentas   -> FUNCIONA
 2) Rede          -> em construção
 3) Pacotes       -> em construção
 4) Arquivos      -> em construção
 5) Navegacao     -> em construção
 6) Sistema       -> em construção
 7) Dev           -> em construção
 8) IA            -> em construção
 9) PowerShell    -> em construção
 11) 🎮 Gaming     -> funciona
 12) 🔍 Procurar   -> funciona
 13) 🛠️ Toolkit   -> funciona
```

### Categorias reais

**1) Ferramentas (`mano_custom_ferramentas`)**
- 1) Limpar cache (pkg clean / apt clean)
- 2) Info sistema (uname, uptime, df)
- 3) Bateria (termux-battery-status)
- 4) Armazenamento (df -h)
- 5) Processos / RAM (free, ps)
- 6) Meu IP (curl ifconfig.me)

**Outras:**
- Gaming, Search, Toolkit já funcionais e sem bug de `Toolkit` maiúsculo

### Correções aplicadas
- Removido `core/` (core/config.sh tinha `toolkit(){ mano_custom_Toolkit }` com T maiúsculo -> command not found)
- Removido `core/menu.sh` que fazia `echo ferramentas` e voltava
- Padronizado tudo minúsculo: `mano_custom_toolkit`, `mano_custom_search`
- Loader único v3.1.5 com dispatch: se função existe chama, se não mostra "em construção"
- `.bashrc` corrigido: só uma linha `source ~/.mano/loader.sh` (sem duplicatas)
- Download limpo: 140 arquivos legados movidos pra `mano-legacy-archive/`

---

## ❌ O que falta criar

### Prioridade Alta
- [ ] **2) Rede** (`categories/rede.sh`) - `mano_custom_rede`
  - Meu IP público + local (ifconfig.me + ip addr)
  - Ping 8.8.8.8 / google.com
  - Scan portas locais (netstat)
  - Speedtest (curl speedtest)

- [ ] **3) Pacotes** (`categories/pacotes.sh`) - `mano_custom_pacotes`
  - pkg update / upgrade
  - Lista pacotes instalados
  - Limpeza

- [ ] **4) Arquivos** (`categories/arquivos.sh`) - `mano_custom_arquivos`
  - ls -la com filtro
  - Criar/apagar pasta
  - Busca rápida

### Prioridade Média
- [ ] **5) Navegacao** - cd rápido, favoritos
- [ ] **6) Sistema** - free, df, top, termux-info
- [ ] **7) Dev** - git status, python, node
- [ ] **8) IA** - integrar `tools/gemini.py` no menu
- [ ] **9) PowerShell** - ou remover do menu se não usar

### Infra
- [ ] `instala.sh` - instalador oficial que clona do GitHub pra `~/.mano`
- [ ] `README.md` com badges, gif do menu
- [ ] `.gitignore` já existe, mas revisar
- [ ] Criar releases / tags v3.1.5, v3.2.0 etc

---

## 🛠️ Comandos que você vai usar TODO DIA

### Desenvolvimento (no ~/mano)
```bash
cd ~/mano
nano categories/rede.sh          # edita
cp categories/rede.sh ~/.mano/categories/  # testa na instalação
source ~/.mano/loader.sh
mano                             # testa menu opção 2
mano-list                        # lista cats
```

### Git / GitHub
```bash
cd ~/mano
git status
git add -A
git commit -m "feat: add rede category"
git push -u origin main
# se limpar tudo
git log --oneline
git remote -v  # tem que mostrar mano-termux
```

### Instalação / Sincronia
```bash
# Sincroniza OFICIAL -> instalação
cp -r ~/mano/categories/* ~/.mano/categories/
cp -r ~/mano/aliases/* ~/.mano/aliases/
cp ~/mano/loader.sh ~/.mano/
cp ~/mano/mano-add ~/.mano/
chmod +x ~/.mano/categories/*.sh ~/.mano/aliases/*.sh ~/.mano/loader.sh ~/.mano/mano-add
source ~/.mano/loader.sh
mano-reload

# Instalação do zero (em outro celular)
git clone https://github.com/SandroBreaker/mano-termux.git ~/.mano
chmod +x ~/.mano/loader.sh ~/.mano/mano-add ~/.mano/categories/*.sh ~/.mano/aliases/*.sh
echo 'source ~/.mano/loader.sh' >> ~/.bashrc
source ~/.bashrc
mano
```

### Limpeza / Debug
```bash
toolkit                          # gera mano-dump.txt da pasta atual
toolkit ~/mano dump-atual.txt    # dump do repo oficial
cat ~/.bashrc | grep mano        # deve ter só 1 linha
type toolkit                     # deve ser aliased to mano_custom_toolkit (t minúsculo)
declare -f mano | head -n 30     # vê função mano atual
```

---

## 📌 Decisões tomadas hoje

1. `/sdcard/Download/mano-v3.1` DELETADO - era fonte de confusão
2. `~/mano` é o ÚNICO oficial DEV
3. `~/.mano` é espelho runtime
4. `core/` removido definitivamente - era V2 bugado
5. Tudo em minúsculo pra evitar bug `Toolkit` vs `toolkit`
6. Fluxo PATCH: só manda arquivo que mudou, não ZIP inteiro

---

## Próximo passo sugerido

Criar `categories/rede.sh` com:
```bash
MANO_CUSTOM_NAME="🌐 Rede"
MANO_CUSTOM_DESC="Ferramentas de rede"
MANO_CUSTOM_FUNC="mano_custom_rede"
```

Quer que eu já gere ele?
