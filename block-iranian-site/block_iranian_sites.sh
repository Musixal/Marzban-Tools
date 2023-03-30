#!/bin/bash

echo -e "Welcome to block-iranian-sites tools \n"

if [ ! -e env ]
then
    echo "WRONG DIRECTORY !"
    exit
fi

echo -e "downloading necessary files... \n"
mkdir -p /var/lib/marzban/assets/
curl -s https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat -O /var/lib/marzban/assets/geosite.dat 
curl -s https://github.com/v2fly/geoip/releases/latest/download/geoip.dat -O /var/lib/marzban/assets/geoip.dat
curl -s https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat -O /var/lib/marzban/assets/iran.dat
echo 'XRAY_ASSETS_PATH = "/var/lib/marzban/assets/"' >> env
read -p 'Enter your website without https:// : ' website
echo -e "\n"
rm xray_config.json
curl -s https://raw.githubusercontent.com/MusiXal/Marzban-Tools/main/block-iranian-site/xray_config.json -O xray_config.json
sed -i 's/www.example.com/'"$website"'/g' xray_config.json
echo -e "Restaring Marzban...\n"
docker compose down
docker compose up -d
echo "Done!"
