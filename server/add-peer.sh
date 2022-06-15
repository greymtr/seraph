#!/usr/bin/env bash

# Used to add gateways to the network

#Usage : add-peer.sh PeerPublicKey

cd ~/seraph-wireguard

printf "Enter Public Key of Peer : "
read pubkey_peer

for i in {2..255}
do
	if [ ! -e peers/$i ]
	then
		ip=$i
		break
	fi
done

echo "Gateway ID : $i"

echo "
[Peer]
PublicKey = "$pubkey_peer"
AllowedIPs = 10.0.0."$ip"/24
" > peers/$ip

wg-quick down wg-seraph

cp head-config /etc/wireguard/wg-seraph.conf

for i in $(ls peers)
do
	cat peers/$i >> /etc/wireguard/wg-seraph.conf
	echo "" >> /etc/wireguard/wg-seraph.conf
done

wg-quick up wg-seraph
