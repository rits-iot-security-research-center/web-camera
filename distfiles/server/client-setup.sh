#!/bin/bash

if [ -z "$1" ]; then 
	echo "USAGE: $0 <clients-list-file>"
	exit 1
fi

cat $1 | while read client
do
	echo "****************************************"
	echo "* client IP address is $client .*"
	echo "****************************************"
	echo "1. apt update"
	ssh -n $client sudo apt update

	echo "2. apt upgrade -y"
	ssh -n $client sudo apt upgrade -y

	echo "3. apt install apache2 -y"
	ssh -n $client sudo apt install apache2 -y

	echo "4. apt install php -y"
	ssh -n $client sudo apt install php -y

	echo "5. apt install sqlite3 php-sqlite3 -y"
	ssh -n $client sudo apt install sqlite3 php-sqlite3 -y

	echo "6. apt install telnetd -y"
	ssh -n $client sudo apt install telnetd -y

	echo "7. apt install ftp -y"
	ssh -n $client sudo apt install ftp -y

   	echo "8. Setup web camera"
	sh client-web-setup.sh $client
done

echo "Client setup shell script is Finished"

exit 0
