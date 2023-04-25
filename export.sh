#!/usr/bin/bash

# Exports the containers

GREEN='\033[0;32m'
RESET='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
log="0"

echo -e "${GREEN}Welcome to the export script for Kerberos.io and Shinobi${RESET}"
echo -e "${RED}This script will export all the containers to a tar file by first stopping the containers${RESET}"
echo -e "${RED}Do you want to continue ?(y/n)${RESET}"
read req

while [ "$req" != "n" ] && [ "$req" != "y" ]
do
    echo "Please enter a valid answer (y/n)"
    read req
done

if [ "$req" == "n" ]; then
    echo "Exiting export script"
    exit
fi

echo -e "${RED}Stopping the containers${RESET}"
docker stop $(docker ps -a -q)
echo -e "${RED}Where do you want to export ? (absolute path)${RESET}"
read path

while [ "$path" == "" ]
do
    echo "Please enter a valid path"
    read path
done

echo -e "${RED}Exporting containers${RESET}"
for container in $(docker ps -a -q); do docker export $container > $container.tar; done
echo -e "${RED}Successfully exported the containers${RESET}"


