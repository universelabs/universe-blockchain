#!/bin/bash

#Gets Go going
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update
sudo apt upgrade -y
sudo apt-get install -y golang-go build-essential
mkdir -p $HOME/go/bin
echo 'export GOPATH=~/go' >> ~/.bash_profile
echo 'export PATH=$PATH:~/go/bin' >> ~/.bash_profile
source ~/.bash_profile

#Clones and installs Gaia
mkdir -p $GOPATH/src/github.com/cosmos
cd $GOPATH/src/github.com/cosmos
git clone https://github.com/cosmos/gaia
cd gaia && make install

#Just putting this here a second time to try something, as it seems not to work the first time
source ~/.bash_profile


#Steps that come after this are manual
