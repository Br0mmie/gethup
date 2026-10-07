#!/usr/bin/env bash

IP="$1"

if [[ -z "$IP" ]]; then
    echo "Usage: $0 <ip-address>"
    exit 1
fi

echo "[*] Waiting for $IP to come online..."

while true; do
    if nmap -Pn --host-timeout 5s -p 22,80,443 "$IP" 2>/dev/null | grep -Eq '^[0-9]+/tcp +(open|closed)'; then
        break 
    fi
    sleep 2
done
    

echo "[+] $IP is up."
echo "[*] Running nmap -sC -sV..."

nmap -Pn -sC -sV "$IP" >> init_nmap_scan.txt
