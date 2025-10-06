#!/data/data/com.termux/files/usr/bin/bash
# 💕 Miner Android GUI by Leafia 💕
# Semua miner disimpan di ~/Android-miner/

clear

# 🎨 Warna
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
WHITE='\033[1;37m'
RESET='\033[0m'

# 🌸 ASCII ART LEAFIA
echo -e "${MAGENTA}"
echo "        ░░████████░░        "
echo "     ████░░░░░░░░████      "
echo "   ██░░░░░░   ░░░░░░░██    "
echo "  ██░░░░░░     ░░░░░░░██   "
echo " ██░░░░░░░     ░░░░░░░░░██ "
echo " ██░░░░░░       ░░░░░░░░░██"
echo " ██░░░░░░░     ░░░░░░░░░██ "
echo "  ██░░░░░░░   ░░░░░░░░░██  "
echo "   ██░░░░░░░ ░░░░░░░░██    "
echo "     ████░░░░░░░░████      "
echo "        ░░████████░░        "
echo -e "${RESET}"
echo -e "${CYAN}💎 Selamat datang di Installer Miner Android by Leafia 💎${RESET}"
sleep 2

# 🔧 Install dependency

echo -e "${YELLOW}>> Mengupdate Termux & memasang dependency...${RESET}"
mv ~/Android-miner/droidminer $PREFIX/bin/
pkg update -y && pkg upgrade -y
pkg install -y git build-essential cmake automake autoconf libtool \
    wget curl nano lua jq clang python

mkdir -p ~/Android-miner
cd ~/Android-miner

# ⛏️ Clone repositori jika belum ada
[[ ! -d "pocominer" ]] && git clone https://github.com/viantmocy/pocominer
[[ ! -d "yentenku" ]] && git clone https://github.com/viantmocy/yentenku
[[ ! -d "RIC-rieminer" ]] && git clone https://github.com/viantmocy/RIC-rieminer

# ▶️ Fungsi jalankan miner
start_miner() {
    case $1 in
        vrsc) cd ~/Android-miner/pocominer && ./start.sh ;;
        ytn)  cd ~/Android-miner/yentenku && ./start.sh ;;
        ric)  cd ~/Android-miner/RIC-rieminer && ./start.sh ;;
    esac
    read -p "Tekan ENTER untuk kembali..."
}

# 📝 Fungsi edit config
edit_config() {
    case $1 in
        vrsc) nano ~/Android-miner/pocominer/config.json ;;
        ytn)  nano ~/Android-miner/yentenku/config.json ;;
        ric)  nano ~/Android-miner/RIC-rieminer/rieMiner.conf ;;
    esac
}

# 📋 Menu interaktif
while true; do
    clear
    echo -e "${WHITE}untuk start ulang ketik droidminer di termux${RESET}"
    echo -e "${MAGENTA}═════════════════════════════════════${RESET}"
    echo -e "       ${CYAN}💎 Droidminer 💎${RESET}      "
    echo -e "${MAGENTA}═════════════════════════════════════${RESET}"
    echo -e " ${YELLOW}[1]${GREEN} Start Verus (VRSC) Miner${RESET}"
    echo -e " ${YELLOW}[2]${GREEN} Start Yenten (YTN) Miner${RESET}"
    echo -e " ${YELLOW}[3]${GREEN} Start Riecoin (RIC) Miner${RESET}"
    echo -e " ${YELLOW}[4]${CYAN} Edit Config Miner${RESET}"
    echo -e " ${YELLOW}[5]${RED} Stop semua miner${RESET}"
    echo -e " ${YELLOW}[6]${RED} Keluar${RESET}"
    echo -e "${MAGENTA}═════════════════════════════════════${RESET}"
    echo -ne "${WHITE}Pilih menu: ${RESET}"
    read choice

    case $choice in
        1) start_miner vrsc ;;
        2) start_miner ytn ;;
        3) start_miner ric ;;
        4)
            echo -e "${CYAN}Pilih config yang mau diedit:${RESET}"
            echo -e " ${YELLOW}[1]${GREEN} VRSC${RESET}"
            echo -e " ${YELLOW}[2]${GREEN} YTN${RESET}"
            echo -e " ${YELLOW}[3]${GREEN} RIC${RESET}"
            echo -ne "${WHITE}Pilih: ${RESET}"
            read c
            case $c in
                1) edit_config vrsc ;;
                2) edit_config ytn ;;
                3) edit_config ric ;;
            esac
        ;;
        5) pkill -9 ccminer; pkill -9 rieMiner; echo -e "${RED}✖ Semua miner dihentikan.${RESET}"; sleep 2 ;;
        6) echo -e "${RED}Keluar...${RESET}"; break ;;
        *) echo -e "${RED}Pilihan tidak valid${RESET}"; sleep 1 ;;
    esac
done
