#!/usr/bin/env bash
MANO_CUSTOM_NAME="🧰 Ferramentas"
MANO_CUSTOM_DESC="Ferramentas úteis do dia a dia"
MANO_CUSTOM_FUNC="mano_custom_ferramentas"

mano_custom_ferramentas() {
    while true; do
        clear
        echo "╔════════════════════════════════════════════╗"
        echo "║ 🧰 FERRAMENTAS ║"
        echo "╚════════════════════════════════════════════╝"
        echo ""
        echo " 1) 🧹 Limpar cache (pkg/apt)"
        echo " 2) 📊 Info do sistema"
        echo " 3) 🔋 Bateria"
        echo " 4) 💾 Armazenamento"
        echo " 5) 📈 Processos / RAM"
        echo " 6) 🌐 Meu IP"
        echo " 7) 📅 Data/Hora"
        echo " 0) ⬅️ Voltar"
        echo ""
        read -rp " >> Escolha: " op
        case "$op" in
            1) pkg clean 2>/dev/null; apt clean 2>/dev/null; echo " ✅ Cache limpo"; sleep 1 ;;
            2) uname -a; echo ""; uptime; echo ""; df -h | head -n 10; read -rp " ENTER..." _ ;;
            3) termux-battery-status 2>/dev/null || echo "sem termux-battery-status"; read -rp " ENTER..." _ ;;
            4) df -h; du -sh ~/.* 2>/dev/null | head -n 20; read -rp " ENTER..." _ ;;
            5) free -h 2>/dev/null; ps aux | head -n 20; read -rp " ENTER..." _ ;;
            6) curl -s ifconfig.me; echo ""; read -rp " ENTER..." _ ;;
            7) date; cal 2>/dev/null; read -rp " ENTER..." _ ;;
            0) return ;;
            *) sleep 1 ;;
        esac
    done
}
