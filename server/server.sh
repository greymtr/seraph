#!/usr/bin/env bash

sudo apt update
sudo apt -y install mosh wireguard python3-pip iptables ufw git nodejs

pip3 install statsmodels numpy pandas Flask matplotlib

mkdir ~/seraph
mkdir ~/seraph-wireguard
cd ~/seraph-wireguard
mkdir peers

umask 077
wg genkey | tee privatekey | wg pubkey > publickey


touch /etc/wireguard/wg-seraph.conf
echo "[Interface]
PrivateKey = "$(cat privatekey)"
Address = 10.0.0.1/24
ListenPort = 51115
PostUp = iptables -A FORWARD -i wg-seraph -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables -A FORWARD -i wg-seraph -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg-seraph -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6tables -D FORWARD -i wg-seraph -j ACCEPT; ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
SaveConfig = true" > /etc/wireguard/wg-seraph.conf

cp /etc/wireguard/wg-seraph.conf head-config

sudo ufw allow 22/tcp
sudo ufw allow 51115/udp
sudo ufw allow 8888
sudo ufw allow 9090
sudo ufw allow 8080
sudo ufw enable
sudo ufw allow mosh

wg-quick up wg-seraph
sudo systemctl enable wg-quick@wg-seraph







