#!/usr/bin/env bash

#Run this in the background

cd ~/seraph-wireguard


while true
do
	wg-quick down wg-seraph
	
	cp head-config /etc/wireguard/wg-seraph.conf
	
	for i in $(ls peers)
	do
		cat peers/$i >> /etc/wireguard/wg-seraph.conf
		echo "" >> /etc/wireguard/wg-seraph.conf
	done
	
	wg-quick up wg-seraph
	
	sleep 5m
done
