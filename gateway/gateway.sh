#!/usr/bin/env bash


#usage : gateway.sh ENDPOINT GATE_ID PUBKEY_SERVER
#
#       ENDPOINT              -   Server IP/Domain
#       GATE_ID               -   Address of Gateway on Server Subnet/VPN
#       PUBKEY_SERVERDPOINT   -   Server WireGuard Public Key


endpoint="$1"
gate_id="$2"
pubkey_server="$3"

sudo apt update
sudo apt -y install mosh wireguard iptables ufw netcat git

mkdir ~/seraph-wireguard
cd ~/seraph-wireguard

umask 077
wg genkey | tee privatekey | wg pubkey > publickey

tput smcup

clear

echo "Public Key : $( cat publickey )"

printf "Enter Endpoint : "
read endpoint

printf "Enter Gate ID : "
read gate_id

printf "Enter Server Public Key: "
read pubkey_server

tput rmcup


touch /etc/wireguard/wg-seraph.conf
echo "[Interface]
PrivateKey = "$(cat privatekey)"
Address = 10.0.0."$gate_id"/24

[Peer]
PublicKey = "$pubkey_server"
Endpoint = "$endpoint":51115
AllowedIPs = 10.0.0."$gate_id"/32
" > /etc/wireguard/wg-seraph.conf

sudo ufw allow 22/tcp
sudo ufw allow 51115/udp
sudo ufw enable
sudo ufw allow mosh

wg-quick up wg-seraph
sudo systemctl enable wg-quick@wg-seraph


