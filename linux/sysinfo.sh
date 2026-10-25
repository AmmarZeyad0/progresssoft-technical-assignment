#!/usr/bin/env bash
# sysinfo.sh: print system information and resource usage
# Author: Ammar Zeyad | ProgressSoft technical assignment, Linux Task 1
# Usage: sudo ./sysinfo.sh

# ----- Collect -----
EXECUTED_BY=$(whoami)
HOST_NAME=$(hostname)
SERVER_IP=$(hostname -I | awk '{print $1}')
PUBLIC_IP=$(curl -4 -sf --max-time 5 ifconfig.me || echo "Unavailable")
OS_VERSION=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
KERNEL=$(uname -r)
ARCH=$(uname -m)
VIRT=$(systemd-detect-virt)
[ "$VIRT" = "none" ] && lspci | grep -qi virtualbox && VIRT="oracle"   # ARM VMs: systemd can't tell
SERVER_TIME=$(date '+%a %b %d %r %Z %Y')
TIMEZONE="$(timedatectl show -p Timezone --value) ($(date +%Z))"
UPTIME=$(uptime -p | cut -d' ' -f2-)
MEM_TOTAL=$(free -h | awk '/^Mem:/ {print $2}')
MEM_USAGE=$(free -h | awk '/^Mem:/ {print $3 " / " $2}')
SWAP_USAGE=$(free -h | awk '/^Swap:/ {print $3 " / " $2}')
CPU_CORES=$(nproc)

# ----- Print -----
row() { printf "  • %-21s %s\n" "$1" "$2"; }

echo "System Information"
row "Executed By:"         "$EXECUTED_BY"
row "Hostname:"            "$HOST_NAME"
row "Server IP:"           "$SERVER_IP"
row "Public IP:"           "$PUBLIC_IP"
row "OS Type and Version:" "$OS_VERSION"
row "Kernel Version:"      "$KERNEL"
row "Architecture:"        "$ARCH"
row "Virtualization:"      "${VIRT^}"
row "Server Time:"         "$SERVER_TIME"
row "Timezone:"            "$TIMEZONE"
row "Uptime:"              "$UPTIME"
echo
echo "Resource Usage"
row "Total Memory:"        "$MEM_TOTAL"
row "Memory Usage:"        "$MEM_USAGE"
row "Swap Usage:"          "$SWAP_USAGE"
row "CPU Cores:"           "$CPU_CORES"
