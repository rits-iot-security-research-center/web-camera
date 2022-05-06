#!/bin/sh

# This program is shell script for setup server environment. 
#
#

# Generate ssh key

ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -N ""
echo Key-pair is generated. Public Key is...
cat $HOME/.ssh/id_ed25519.pub

# Change directory permission to 700 for pi.

chmod 700 $HOME/.ssh

# Download client files.

wget https://github.com/rits-iot-security-research-center/web-camera/raw/main/distfiles/clients/www.tar.gz
wget https://github.com/rits-iot-security-research-center/web-camera/raw/main/distfiles/clients/php.ini.dist
wget https://github.com/rits-iot-security-research-center/web-camera/raw/main/distfiles/clients/apache2.conf.dist

