#!/bin/bash

[[ $(cat /var/log/nginx.log 2>/dev/null | grep "^130.*21/Jul/2022:16:2[0-5].* 500 " | awk '{print $7}') == $(cat /var/log/nginx_parsed.log 2>/dev/null) ]] && STATUS1=Success
echo "1: $STATUS1"

IP=$(ip a | grep eth0 -A2 | grep "inet " | awk '{print $2}' | awk -F/ '{print $1}')
TEST1=$(cat /etc/redis/redis_*.conf | grep -v "^#" | grep "^bind.*$IP")
TEST2=$(for line in {1..9}; do echo "bind $IP"; done)
[[ $TEST1 == $TEST2 ]] && STATUS11=Success
echo "2.1: $STATUS11"
