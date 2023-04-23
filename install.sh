#!/usr/bin/bash

# Install the package

GREEN='\033[0;32m'
RESET='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
log="0"
req=""


echo -e "${GREEN}Welcome to the installation script for Kerberos.io and Shinobi${RESET}"
echo -e "${RED}Before continuing, you must create your Kerberos Hub account at: https://app.kerberos.io/login${RESET}"
echo -e "${RED}You must have your Kerberos Hub username, private key and public key at your disposal${RESET}"
echo -e "${RED}You must have a proper Docker installation, please refer to the report if it's not the case${RESET}"
echo -e "${RED}This script will also install Shinobi as an emergency solution on port 8080:8080${RESET}"
echo -e "${RED}Do you confirm these requirements ?(y/n)${RESET}"
read req

while [ "$req" != "n" ] && [ "$req" != "y" ]
do
    echo "Please enter a valid answer (y/n)"
    read req
done

if [ "$req" == "n" ]; then
    echo "Exiting installation script"
    exit
fi



# Generate the docker compose file for kerberos
python3 agent_generator.py
# Install the docker compose file
docker compose -p kerberos -f docker-compose.yml up -d
# Install Shinobi on port 8080
bash <(curl -s https://gitlab.com/Shinobi-Systems/Shinobi-Installer/raw/master/shinobi-docker.sh)

