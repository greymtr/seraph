#!/usr/bin/env bash


cd ~/seraph-wireguard

wg-quick down wg-seraph

cp head-config /etc/wireguard/wg-seraph.conf

for i in $(ls peers)
do
	cat peers/$i >> /etc/wireguard/wg-seraph.conf
	echo "" >> /etc/wireguard/wg-seraph.conf
done

wg-quick up wg-seraph
