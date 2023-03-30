#!/bin/bash

echo "Welcome to block-iranian-sites tools"

if [ ! -e env ]
then
    echo "WRONG DIRECTORY !"
    exit
fi

echo "downloading necessary files..."
mkdir -p /var/lib/marzban/assets/
curl -s -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
curl -s -O /var/lib/marzban/assets/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
curl -s -O /var/lib/marzban/assets/iran.dat https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat
echo 'XRAY_ASSETS_PATH = "/var/lib/marzban/assets/"' >> env
read -p 'Enter your website without https:// : ' website
rm xray_config.json
curl -s -O xray_config.json https://raw.githubusercontent.com/MusiXal/Marzban-Tools/main/block-iranian-site/xray_config.json
sed -i 's/www.example.com/'"$website"'/g' xray_config.json
echo "Restaring Marzban..."
docker compose down
docker compose up -d
echo "Done!"
