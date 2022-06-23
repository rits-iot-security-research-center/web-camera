#!/bin/bash

if [ -z "$1" ]; then
	echo "USAGE: $0 <client-ip-address>"
	exit 1
fi

scp www.tar.gz $1:/tmp/www.tar.gz
ssh -n $1 "(cd /; sudo tar xfvz /tmp/www.tar.gz)"
scp php.ini.dist $1:/tmp/php.ini
ssh -n $1 "sudo sh -c echo 'www-data        ALL=(ALL:ALL)   NOPASSWD: /usr/bin/libcamera-still' > /etc/sudosers.d/010_webcamera"
ssh -n $1 "sudo mv -f /tmp/php.ini /etc/php/7.?/apache2"
scp apache2.conf.dist $1:/tmp/apache2.conf
ssh -n $1 "sudo mv -f /tmp/apache2.conf /etc/apache2/"
ssh -n $1 "sudo crontab -u www-data -r"
ssh -n $1 'echo "sudo chmod 777 /dev/vchiq" | sudo sh -c "cat > /etc/init.d/chmod-vchiq; sudo chmod +x /etc/init.d/chmod-vchiq"'
ssh -n $1 '(cd /etc/rc3.d; sudo rm -f S01chmod-vchiq; sudo ln -s ../init.d/chmod-vchiq S01chmod-vchiq)'
ssh -n $1 'echo "* * * * * /var/www/scripts/pic.sh" | sudo crontab -u www-data -'
ssh -n $1 'sudo a2enmod `basename /etc/apache2/mods-available/php*.conf .conf`'
