#!/usr/bin/env bash

cd ~/seraph-wireguard

wg-quick down wg-seraph

printf "> Enter Peer's Public Key : "
read $pubkey_peer

printf "\n"

printf "> Enter Peer's IP Address : "
read $ip

echo "
[Peer]
PublicKey = "$pubkey_peer"
AllowedIPs = 10.0.0."$ip"/24

" > peers/$ip


