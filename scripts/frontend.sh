#!/bin/bash


# **********************************************************
#                     Modules and Running                  #
# **********************************************************

cd open-ethereum-pool
cd www

npm install -g ember-cli@2.9.1
npm install ember-cli-cookie@0.2.0
npm install -g bower
npm install
bower install
./build.sh

ember server
