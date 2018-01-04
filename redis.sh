#!/bin/bash


get_update()
{
    apt-get update
}

get_update
echo -e "\033[32mInstalling redis-server"

apt-get install redis-server

systemctl restart redis-server.servic e

echo -e "\033[32mEnabling on reboot"

systemctl enable redis-server.service