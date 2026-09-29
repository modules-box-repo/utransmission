#!/bin/sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[1/5] Updating packages...${NC}"
apk update && echo -e "${GREEN}[1/5] Update complete${NC}"

echo -e "${BLUE}[2/5] Upgrading packages...${NC}"
apk upgrade && echo -e "${GREEN}[2/5] Upgrade complete${NC}"

echo -e "${BLUE}[3/5] Installing Transmission...${NC}"
apk add transmission transmission-daemon
echo -e "${GREEN}[3/5] Transmission installed successfully${NC}"

echo -e "${BLUE}[4/5] Installing wget and unzip...${NC}"
apk add wget unzip
echo -e "${GREEN}[4/5] wget and unzip installed successfully${NC}"

echo -e "${BLUE}[5/5] Installing Transmission Next UI...${NC}"
wget -O release.zip \
    https://github.com/hisproc/transmission-next-ui/releases/latest/download/release.zip

unzip -o release.zip -d /usr/share/transmission/public_html/

rm -f release.zip

echo -e "${GREEN}[5/5] Transmission Next UI installed successfully${NC}"
echo -e "${GREEN}All done.${NC}"