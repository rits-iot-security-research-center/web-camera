#!/bin/bash

# This program is shell script for setup IoT Camera. 
#
#

if [ -z "$1" ]; then
	echo "USAGE: $0 <server_ip_address>"
	exit 1
fi

mkdir -p $HOME/.ssh
chmod -f 700 $HOME/.ssh
if [ ! -e $HOME/.ssh/id_ed25519 ]; then 
	ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -N ""
fi

cat $HOME/.ssh/id_ed25519.pub | ssh $1 "cat >> $HOME/.ssh/authorized_keys"
ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1 | ssh $1 "cat >> ~/clients.txt"
scp $1:$HOME/.ssh/id_ed25519.pub $HOME/.ssh/authorized_keys
