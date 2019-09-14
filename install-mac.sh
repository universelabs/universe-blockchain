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
- gaiad"

read -p "Are you ok with that? (y/N): " choice

case "$choice" in
    y|Y) echo -e "Continuing with install... This could take a moment.\n";;
    *) echo "Aborting."; exit 1;;
esac

# REMOVES EXISTING INSTALL
rm -rf ~/universe
rm -rf ~/.gaiad
rm -rf ~/.gaiacli

# DOWNLOADS DAEMON AND CLI ~/universe
echo "Downloading and installing.... galaxycli and galaxyd."
mkdir ~/universe
cd ~/universe
curl -LO#f https://github.com/universelabs/universe-network/releases/download/v0.1/gaiacli
curl -LO#f https://github.com/universelabs/universe-network/releases/download/v0.1/gaiad
chmod +x gaiacli
chmod +x gaiad

echo -e "\nInitializing gaiad...."

# INITALIZES THE BLOCKCHAIN
./gaiad init &>/dev/null

echo -e "\nFetching genesis block...."
# fetches genesis.json
curl -LO#f https://github.com/universelabs/universe-network/raw/master/genesis.json
mv genesis.json ~/.gaiad/config/genesis.json

############ THIS SECTION COMMENTED OUT UNTIL CONFIRMATION ON NECESSITY
# echo -e "\n
# Adding seeds to config...."
# find-and-replace on config.toml to set seed node
# original_string='seeds = ""'
# replace_string='seeds = "a0cd321854769978eea1ffb57d341ecaf6551905@149.28.45.92:26656,ea7ff5667f65c52e8c673bc96885a66fe6c1ec7b@98.118.185.162:26656,642f7a68f1af520a1b05134382fe97ba7513ee41@45.77.36.79:26656"'
# sed -i -e "s/$original_string/$replace_string/g" ~/.gaiad/config/config.toml

# GET MONIKER
echo -e "\nUniverse needs to distinguish individual nodes from one another. This is \naccomplished by having users choose a Universe node name. \n\nRecommended name: 'galaxy-node'\n"
read -p "Name your Universe node: " name
moniker_original="moniker = \"\""
moniker_actual="moniker = \"$name\""
sed -i -e "s/$moniker_original/$moniker_actual/g" "$HOME/.gaiad/config/config.toml"

# SUMMARY
echo -e "\033[1;35m\n\nWelcome to the Universe network \xF0\x9F\x8E\x89 \xF0\x9F\x8C\x8C ..................... \033[0m\n
Universe blockchain is now installed and ready to sync......
...............................................................................
Navigate into the Universe directory by typing the following;
cd ~/universe
..............................................................................."

echo -e "\nThen open a new terminal window and sync your Universe Node by typing....
~/universe
./gaiad start
Note: Syncing your Universe Node can take a while."
