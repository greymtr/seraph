#!/usr/bin/env bash

#usage : first arg is dev id

while true; 
do 
	(( n = RANDOM % 30 ));
	(( port = RANDOM % 10 ));
	n_r=$(printf '%s.%s\n' $(( n / 10 )) $(( n % 10 )));
	echo -e "$port \t $n_r"
	curl --header "X-Forwarded-For: 192.168.0."$1 http://127.0.0.1:8080/r/$port/$n_r;
	sleep 1s;
done

