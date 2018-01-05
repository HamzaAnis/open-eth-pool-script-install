#!/bin/bash



cd watchman
git checkout v4.9.0  # the latest stable release
./autogen.sh
./configure
 make
sudo make install
