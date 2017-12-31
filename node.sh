#!/bin/bash

apt-get install -y build-essential

echo -e "Installing Node and Npm"

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs


apt-get install npm