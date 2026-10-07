#!/usr/bin/env bash

IP="$1"

if [[ -z "$IP" ]]; then
    echo "Usage: $0 <ip-address>"
    exit 1
fi

echo "[*] Waiting for $IP to come online..."

until nmap -sn "$IP" 2>/dev/null | grep -q "Host is up"; do
    sleep 2
done

echo "[+] $IP is up."
echo "[*] Running nmap -sC -sV..."

nmap -sC -sV "$IP" >> init_nmap_scan.txt
