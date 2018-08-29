#!/bin/bash

# **********************************************************
#                           GOLANG                         #
# **********************************************************

VERSION="1.10.3"

print_help() {
    echo "Usage: bash goinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  --32\t\tInstall 32-bit version"
    echo -e "  --64\t\tInstall 64-bit version"
    echo -e "  --arm\t\tInstall armv6 version"
    echo -e "  --darwin\tInstall darwin version"
    echo -e "  --remove\tTo remove currently installed version"
}

get_update()
{
    sudo apt-get update
}


if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    # assume Zsh
    shell_profile="zshrc"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    shell_profile="bashrc"
fi

if [ "$1" == "--32" ]; then
    DFILE="go$VERSION.linux-386.tar.gz"
    elif [ "$1" == "--64" ]; then
    DFILE="go$VERSION.linux-amd64.tar.gz"
    elif [ "$1" == "--arm" ]; then
    DFILE="go$VERSION.linux-armv6l.tar.gz"
    elif [ "$1" == "--darwin" ]; then
    DFILE="go$VERSION.darwin-amd64.tar.gz"
    elif [ "$1" == "--remove" ]; then
    rm -rf "$HOME/.go/"
    sed -i '/# GoLang/d' "$HOME/.${shell_profile}"
    sed -i '/export GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '/:$GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '/export GOPATH/d' "$HOME/.${shell_profile}"
    sed -i '/:$GOPATH/d' "$HOME/.${shell_profile}"
    echo "Go removed."
    exit 0
    elif [ "$1" == "--help" ]; then
    print_help
    exit 0
    
fi

if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
    echo "The 'go' or '.go' directories already exist. Exiting."
else
    echo "Downloading $DFILE ..."
    wget https://storage.googleapis.com/golang/$DFILE -O /tmp/go.tar.gz
    
    if [ $? -ne 0 ]; then
        echo "Download failed! Exiting."
        exit 1
    fi
    
    echo "Extracting File..."
    tar -C "$HOME" -xzf /tmp/go.tar.gz
    mv "$HOME/go" "$HOME/.go"
    touch "$HOME/.${shell_profile}"
    {
        echo '# GoLang'
        echo 'export GOROOT=$HOME/.go'
        echo 'export PATH=$PATH:$GOROOT/bin'
        echo 'export GOPATH=$HOME/go'
        echo 'export PATH=$PATH:$GOPATH/bin'
    } >> "$HOME/.${shell_profile}"
    
    mkdir -p $HOME/go/{src,pkg,bin}
    echo -e "\nGo $VERSION was installed.\nMake sure to relogin into your shell or run:"
    echo -e "\n\tsource $HOME/.${shell_profile}\n\nto update your environment variables."
    echo "Tip: Opening a new terminal window usually just works. :)"
    rm -f /tmp/go.tar.gz
fi


# **********************************************************
#                           NPM                            #
# **********************************************************


echo -e "Installing Node and Npm"

if ! [ -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed.' >&2
    apt-get install curl
else
    echo "Curl is Present"
fi


if ! [ -x "$(command -v node)" ]; then
    # Installing build essentials
    apt-get install -y build-essential
    
    # Getting the lastest resource.
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    apt-get install -y nodejs
    
fi


# Installing npm
if ! [ -x "$(command -v curl)" ]; then
    apt-get install npm
fi

# **********************************************************
#                           NGINX                          #
# **********************************************************

echo -e "\033[32mInstalling nginx"
# get_update
apt-get install nginx
echo y | command

ufw app list
ufw allow 'Nginx HTTP'
ufw status
echo -e "\033[32mStarting nginx service"
systemctl start nginx
echo -e "\033[32mEnabling nginx to run on reboot"
systemctl enable nginx


# **********************************************************
#                       REDIS Server                       #
# **********************************************************

get_update

echo -e "\033[32mInstalling redis-server"
apt-get install redis-server

# Closing and starting the server if already started
systemctl restart redis-server.servic e

# Enabling the service on reboot
echo -e "\033[32mEnabling on reboot"
systemctl enable redis-server.service



# **********************************************************
#                           Wacthman                       #
# **********************************************************

apt-get install -y autoconf automake build-essential python-dev libtool m4

git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.9.0  # the latest stable release
./autogen.sh
./configure
make
sudo make install

# Increasing limit for watchman
echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_instances && watchman shutdown-server && sudo sysctl -p


# **********************************************************
#                           GETH                           #
# **********************************************************

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
screen geth --rpc --fast #syncing



