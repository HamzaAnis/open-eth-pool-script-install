#!/bin/bash


get_update()
{
    apt-get update
}
echo -e "\033[31mInstalling geth"

apt-get install software-properties-common
add-apt-repository -y ppa:ethereum/ethereum

get_update

apt-get install ethereum

if [ "$1" == "--create" ]; then
    geth account new
fi
echo -e '\033[1;91mStarting geth'
screen geth --rpc --fast