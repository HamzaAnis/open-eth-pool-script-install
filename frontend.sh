#!/bin/bash

cd www

sudo npm install -g ember-cli@2.9.1
sudo npm install -g bower
sudo npm install
bower install
sudo ./build.sh