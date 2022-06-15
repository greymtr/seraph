#!/usr/bin/env bash

cd ~/seraph-wireguard

pubkey_peer="$1"
ip="$2"

echo "
[Peer]
PublicKey = "$pubkey_peer"
AllowedIPs = 10.0.0."$ip"/24
" > peers/$ip


