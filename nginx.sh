#!/bin/bash

get_update()
{
    apt-get update
}

get_update
echo -e "\033[32mInstalling nginx"
apt-get install nginx
echo y | command

ufw app list
ufw allow 'Nginx HTTP'
ufw status
echo -e "\033[32mStarting nginx service"
systemctl start nginx