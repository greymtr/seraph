#!/usr/bin/env bash

#Usage : add-peer.sh PeerPublicKey

cd ~/seraph-wireguard

pubkey_peer="$1"

for i in {2..255}
do
	if [ ! -e peers/$i ]
	then
	    ip=$i
		break
	fi
done

echo $i

echo "
[Peer]
PublicKey = "$pubkey_peer"
AllowedIPs = 10.0.0."$ip"/24
" > peers/$ip


