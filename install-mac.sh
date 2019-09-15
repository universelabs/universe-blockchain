#!/bin/bash
set -e

# UNIVERSE ASCII GRAPHIC
echo -e "
                                                       +
                                     +
                      +                       +
                              +
                                 +        +
                  +
                          +     +                +
                       +          +
    Universe                  +
                +                       +
                      +
        +                +         +
                              +
                   +
"

# ASK FOR CONSENT
echo -e "This script will remove previously installed directories:
- gaiacli
- gaiad
- .universe
And upgrade you to the latest Universe Blockchain"

read -p "Are you ok with that? (y/N): " choice

case "$choice" in
    y|Y) echo -e "Continuing with install... This could take a moment.\n";;
    *) echo "Aborting."; exit 1;;
esac

# REMOVES EXISTING INSTALL
rm -rf ~/.universe
rm -rf ~/.gaiad
rm -rf ~/.gaiacli

# DOWNLOADS DAEMON AND CLI ~/universe
echo "Downloading and installing.... gaiacli and gaiad."
mkdir ~/.universe
cd ~/.universe
curl -LO#f https://github.com/universelabs/universe-network/releases/download/v0.1/gaiacli
curl -LO#f https://github.com/universelabs/universe-network/releases/download/v0.1/gaiad
chmod +x gaiacli
chmod +x gaiad

echo -e "\nInitializing gaiad...."


# GET MONIKER
echo -e "\nUniverse needs to distinguish individual nodes from one another. This is \naccomplished by having users choose a Universe node name. \n\nRecommended name: 'Universe-node'\n"
read -p "Name your Universe node: " name

# INITALIZES THE BLOCKCHAIN 
./gaiad init name --chain-id universe &>/dev/null

# FETCHES GENESIS.JSON
echo -e "\nFetching genesis block...."
curl -LO#f https://github.com/universelabs/universe-network/raw/master/genesis.json
mv genesis.json ~/.gaiad/config/genesis.json

# ADD SEEDS TO CONFIG.TOML
echo -e "\n
Adding seeds to config...."
original_string='seeds = ""'
replace_string='seeds = "c22d2888eae9e6a1a4b869b75f9055c2b1636fad@157.245.98.69:26656,5e82cc5efa3c9cc1d4440c493a58fbf5abc2158d@167.71.101.150:26656"'
sed -i -e "s/$original_string/$replace_string/g" ~/.gaiad/config/config.toml

# SUMMARY
echo -e "\033[1;35m\n\nWelcome to the Universe network \xF0\x9F\x8E\x89 \xF0\x9F\x8C\x8C ..................... \033[0m\n
Universe blockchain is now installed and ready to sync......
...............................................................................
Navigate into the Universe directory by typing the following;
cd ~/.universe
..............................................................................."

echo -e "\nThen open a new terminal window and sync your Universe Node by typing....
~/.universe
./gaiad start
Note: Syncing your Universe Node can take a while.

To Uninstall, Paste this into your terminal:
bash <(curl -s https://raw.githubusercontent.com/universelabs/universe-network/master/uninstall-mac.sh)
"
