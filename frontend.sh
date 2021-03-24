#!/bin/bash


# **********************************************************
#                     Modules and Running                  #
# **********************************************************

cd open-ethereum-pool
cd www
chmod -R 777 . #Permission issues
npm install -g ember-cli@2.18.2
npm install ember-cli-cookie@0.2.0
npm install -g bower
chown -R $USER:$GROUP ~/.npm
chown -R $USER:$GROUP ~/.config
npm install
bower install --allow-root
npm i intl-format-cache

./build.sh

ember server
