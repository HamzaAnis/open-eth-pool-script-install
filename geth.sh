#!/bin/bash


get_update()
{
    apt-get update
}
echo -e "\033[32mInstalling geth"

apt-get install software-properties-common
add-apt-repository -y ppa:ethereum/ethereum

get_update

apt-get install ethereum

if [ "$1" == "--create" ]; then
    geth account new
fi
echo -e '\033[1;92mStarting geth'
screen geth --rpc --fast


