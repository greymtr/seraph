#!/usr/bin/env bash

sudo apt update
sudo apt -y install mosh wireguard iptables ufw netcat git

mkdir ~/seraph-wireguard
cd ~/seraph-wireguard

umask 077
wg genkey | tee privatekey | wg pubkey > publickey

touch /etc/wireguard/wg-seraph.conf
echo "[Interface]
PrivateKey = "$(cat privatekey)"
Address = 10.0.0.2/24

[Peer]
PublicKey = m7rXNdU9qmlidc2mgpRe21Zt8WpSAGm6phFZvI76cnc=
Endpoint = 192.46.213.35:51115
AllowedIPs = 10.0.0.0/24
" > /etc/wireguard/wg-seraph.conf

sudo ufw allow 22/tcp
sudo ufw allow 51115/udp
sudo ufw enable
sudo ufw allow mosh

wg-quick up wg-seraph
sudo systemctl enable wg-quick@wg-seraph






