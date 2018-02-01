#!/bin/bash


# **********************************************************
#                     Modules and Running                  #
# **********************************************************

cd open-ethereum-pool
cd www
sudo chmod -R 777 . #Permission issues
sudo npm install -g ember-cli@2.9.1
sudo npm install ember-cli-cookie@0.2.0
sudo npm install -g bower
sudo npm install
bower install
sudo ./build.sh

ember server

