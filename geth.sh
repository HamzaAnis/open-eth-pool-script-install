#!/bin/bash

get_update() 
{
apt-get update
}
echo -e "Installing geth"

apt-get install software-properties-common
add-apt-repository -y ppa:ethereum/ethereum

get_update

apt-get install ethereum