#!/usr/bin/bash

# Install the package

GREEN='\033[0;32m'
RESET='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
log="0"
req=""


echo -e "${GREEN}Welcome to the installation script for Kerberos.io, suite of camera surveillance program${RESET}"
echo -e "${RED}Before continuing, you must create your Kerberos Hub account at: https://app.kerberos.io/login${RESET}"
echo -e "${RED}You must also have your Kerberos Hub username, private key and public key at your disposal${RESET}"
echo -e "${RED}Do you confirm these requirements ?(y/n)${RESET}"
read req
if [ "$req" != "y" ]; then
    echo "Exiting program"
    exit
fi
python3 agent_generator.py

