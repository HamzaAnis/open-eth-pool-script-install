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

echo -e '\033[1;92mMaking a geth service'

echo "[Unit]
Description=Ethereum Go Client
[Service]
ExecStart=/usr/bin/geth --fast --cache=16 --datadir=/mnt/eth-blockchain --identity=@bkawk --keystore=/mnt/eth-blockchain --rpc --rpcport=8882 --rpccorsdomain=* --rpcapi=web3,db,net,eth
Restart=always
RestartSec=30
Type=simple
User=root
Group=root
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/geth.service


systemctl daemon-reload
systemctl enable geth.service


echo -e '\033[1;92mStarting geth'
screen geth --rpc --fast
