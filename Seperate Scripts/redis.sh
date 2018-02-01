#!/bin/bash


get_update()
{
    apt-get update
}

get_update

echo -e "\033[32mInstalling redis-server"
apt-get install redis-server

# Closing and starting the server if already started
systemctl restart redis-server.servic e

# Enabling the service on reboot
echo -e "\033[32mEnabling on reboot"
systemctl enable redis-server.service