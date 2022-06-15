#!/usr/bin/env bash

#Run this in the background

cd ~/seraph-wireguard


while true
do
	
	cp head-config /etc/wireguard/wg-seraph.conf
	
	for i in $(ls peers)
	do
		cat peers/$i >> /etc/wireguard/wg-seraph.conf
		echo "" >> /etc/wireguard/wg-seraph.conf
	done
	
	
	sleep 5m
done
