#!/usr/bin/env bash

# Used to remove gateways to the network

#Usage : add-peer.sh PeerPublicKey

cd ~/seraph-wireguard

echo "List of current Devices :"

for i in $(ls peers)
do
	printf "$i\t"
done

printf "\n\n"

while true
do
	printf "Enter Device ID to remove :"
	read $device_id

	if [ ! -e peers/$device_id ]
	then
		echo "Device ID doesn't exist"
	else
		rm peers/$device_id
		echo "Done"
		break
	fi
done

wg-quick down wg-seraph

cp head-config /etc/wireguard/wg-seraph.conf

for i in $(ls peers)
do
	cat peers/$i >> /etc/wireguard/wg-seraph.conf
	echo "" >> /etc/wireguard/wg-seraph.conf
done

wg-quick up wg-seraph
