#!/bin/bash


# **********************************************************
#                     Modules and Running                  #
# **********************************************************

cd open-ethereum-pool
cd www
sudo chmod -R 777 . #Permission issues
sudo npm install -g ember-cli@2.18.2
sudo npm install ember-cli-cookie@0.2.0
sudo npm install -g bower
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config
sudo npm install
sudo bower install --allow-root
sudo npm i intl-format-cache

sudo ./build.sh

sudo chmod -R 755 . #Bring Permission Levels Down to Appropriate Level

sudo ember server
