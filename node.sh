#!/bin/bash

echo -e "Installing Node and Npm"

# Installing build essentials
apt-get install -y build-essential

# Getting the lastest resource.

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs

# Installing npm
apt-get install npm
