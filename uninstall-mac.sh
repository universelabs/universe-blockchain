read -p "Would you like to remove the Universe Blockchain from your computer? (Y/n)" choice

case "$choice" in
    y|Y) echo -e "Uninstalling";;
    *) echo "Aborting."; exit 1;;
esac

# UNINSTALLS UNIVERSE
rm -rf ~/.universe
rm -rf ~/.gaiad
rm -rf ~/.gaiacli

echo "Universe has been successfully Uninstalled.  Thank you!"
